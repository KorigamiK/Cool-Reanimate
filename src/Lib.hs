module Lib (
          nord3
        , nord4
        , nord5
        , nord6
        , nord7
        , nord8
        , nord9
        , nord10
        , nord11
        , nord12
        , nord13
        , nord14
        , nord15
        , nordPalette
        ) where

import           Codec.Picture (PixelRGBA8 (PixelRGBA8))

nord3 :: PixelRGBA8
nord3 = PixelRGBA8 76 86 106 255

nord4 :: PixelRGBA8
nord4 = PixelRGBA8 216 222 233 255

nord5 :: PixelRGBA8
nord5 = PixelRGBA8 229 233 240 255

nord6 :: PixelRGBA8
nord6 = PixelRGBA8 236 239 244 255

nord7 :: PixelRGBA8
nord7 = PixelRGBA8 143 188 187 255

nord8 :: PixelRGBA8
nord8 = PixelRGBA8 136 192 208 255

nord9 :: PixelRGBA8
nord9 = PixelRGBA8 129 161 193 255

nord10 :: PixelRGBA8
nord10 = PixelRGBA8 94 129 172 255

nord11 :: PixelRGBA8
nord11 = PixelRGBA8 191 97 106 255

nord12 :: PixelRGBA8
nord12 = PixelRGBA8 208 135 112 255

nord13 :: PixelRGBA8
nord13 = PixelRGBA8 235 203 139 255

nord14 :: PixelRGBA8
nord14 = PixelRGBA8 163 190 140 255

nord15 :: PixelRGBA8
nord15 = PixelRGBA8 180 142 173 255

nordPalette :: [PixelRGBA8]
nordPalette = [ nord8
              , nord7
              , nord8,  nord9,  nord10, nord11
              , nord12, nord13, nord14, nord15, nord15, nord11]
