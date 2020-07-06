module FileSize where

import Prelude
import Data.Generic.Rep         (class Generic)
import Data.Generic.Rep.Show    (genericShow)
import Data.Maybe               (Maybe(..))
import Data.Number.Format       (toStringWith, fixed)
import Math                     (pow)

data SizeUnit
  = Byte
  | Kilobyte
  | Megabyte
  | Gigabyte
  | Terabyte

derive instance eqSizeUnit :: Eq SizeUnit
derive instance genericSizeUnit :: Generic SizeUnit _

instance showSizeUnit :: Show SizeUnit where
  show = genericShow

-- Get bytes per unit
getBytes :: SizeUnit -> Number
getBytes Byte     = 1.0
getBytes Kilobyte = pow 2.0 10.0
getBytes Megabyte = pow 2.0 20.0
getBytes Gigabyte = pow 2.0 30.0
getBytes Terabyte = pow 2.0 40.0

-- Get SizeUnit depending on the number of bytes passed in
getSizeUnit :: Number -> Maybe SizeUnit
getSizeUnit bytes
  | bytes >= getBytes Byte     && bytes < getBytes Kilobyte = Just Byte
  | bytes >= getBytes Kilobyte && bytes < getBytes Megabyte = Just Kilobyte
  | bytes >= getBytes Megabyte && bytes < getBytes Gigabyte = Just Megabyte
  | bytes >= getBytes Gigabyte && bytes < getBytes Terabyte = Just Gigabyte
  | bytes >= getBytes Terabyte && bytes < (pow 2.0 50.0)    = Just Terabyte
  | otherwise  = Nothing

-- Get a human readable string of size
getHumanSize :: Number -> String
getHumanSize bytes = case sUnit of
  Just Byte     -> (show bytes) <> " bytes"
  Just Kilobyte -> (toStringWith (fixed 1) (bytes / getBytes Kilobyte)) <> " kb"
  Just Megabyte -> (toStringWith (fixed 1) (bytes / getBytes Megabyte)) <> " mb"
  Just Gigabyte -> (toStringWith (fixed 1) (bytes / getBytes Gigabyte)) <> " gb"
  Just Terabyte -> (toStringWith (fixed 1) (bytes / getBytes Terabyte)) <> " tb"
  Nothing       -> ""
  where
    sUnit = getSizeUnit bytes

