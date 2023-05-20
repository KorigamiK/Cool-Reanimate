#!/usr/bin/env stack
-- stack runghc --package reanimate
{-# LANGUAGE ApplicativeDo     #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE PackageImports    #-}

module Main (main) where

import           Reanimate

import           Codec.Picture
import           Control.Lens                           ((&), (^.))
import           Control.Monad
import           Graphics.SvgTree
import           Lib                                    (nord3, nordPalette)
import           System.Random
import           "random-shuffle" System.Random.Shuffle

main :: IO ()
main = reanimate $ addStatic bg latexExample
  where
    bg = mkBackgroundPixel (PixelRGBA8 46 52 64 255)

latexExample :: Animation
latexExample = scene $ do
     -- Fading text
    -- let textSvg = withFillColorPixel nord11 $ translate (-5.75) 0 $ scale 1 $ latex "\\Large \\textit{Gaussian Integral}"
    -- play $ animate (\t -> withFillOpacity (1 - t*0.8) textSvg)
    --   & applyE (overBeginning 5 fadeOutE)

    -- Draw equation
    forM_ glyphs $ \(fn, _, elt) ->
      newSpriteSVG $ withFillColorPixel nord3 $ fn elt
    play $ drawAnimation strokedSvg
    forM_ glyphs $ \(fn, _, elt) ->
      newSpriteSVG $ withFillColorPixel nord3 $ fn elt

    -- Undraw equations
    play $ drawAnimation' (Just 0xdeadbeef) 1 0.1 strokedSvg
      & reverseA
    wait 1
  where
    glyphs = svgGlyphs svg
    strokedSvg =
      withStrokeWidth (defaultStrokeWidth*0.5) $
      withStrokeColor "white" svg
      -- the gaussian integral
    svg = lowerTransformations $ simplify $ scale 2 $ center $
      latexAlign "\\int^{\\infty}_{-\\infty} e^{-x^{2}} = \\sqrt{\\pi}"

drawAnimation :: SVG -> Animation
drawAnimation = drawAnimation' Nothing 0.5 0.3

drawAnimation' :: Maybe Int -> Double -> Double -> SVG -> Animation
drawAnimation' mbSeed fillDur step svg = scene $ do
  forM_ (zip [0..] $ shuf $ zip (svgGlyphs svg) nordPalette) $ \(n, ((fn, attr, tree), color)) -> do
    let sWidth =
          case toUserUnit defaultDPI <$> (attr ^. strokeWidth) of
            Just (Num d) -> d
            _unspecifiedWidth            -> defaultStrokeWidth
    fork $ do
      wait (n*step)
      play $ mapA (withFillColorPixel color . fn) (animate (\t -> withFillOpacity 0 $ partialSvg t tree)
        & applyE (overEnding fillDur $ fadeLineOutE sWidth))
    fork $ do
      wait (n*step+(1-fillDur))
      newSprite $ do
        t <- spriteT
        return $
          withStrokeWidth 0 $ withFillOpacity (min 1 $ t/fillDur) (withFillColorPixel color $ fn tree)
  where
    shuf lst =
      case mbSeed of
        Nothing   -> lst
        Just seed -> shuffle' lst (length lst) (mkStdGen seed)

