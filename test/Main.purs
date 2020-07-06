module Test.Main where

import Prelude

import Effect                           (Effect)
import Effect.Aff                       (launchAff_)
import Data.Maybe                       (Maybe(..))
import Test.Spec                        (describe, it)
import Test.Spec.Assertions             (shouldEqual)
import Test.Spec.Reporter.Console       (consoleReporter)
import Test.Spec.Runner                 (runSpec)

import FileSize                         (SizeUnit(..)
                                        ,getHumanSize
                                        ,getSizeUnit)

main :: Effect Unit
main = launchAff_ $ runSpec [consoleReporter] do
  describe "purescript-filesize" do
    describe "getSizeUnit" do
      it "1023 should return Byte(s)" do
        let byte = getSizeUnit 1023.0
        byte `shouldEqual` Just Byte
      it "1024 should return Kilobyte" do
        let kb = getSizeUnit 1024.0
        kb `shouldEqual` Just Kilobyte
      it "1048576 bytes should return Megabyte" do
        let mb = getSizeUnit 1048576.0 
        mb `shouldEqual` Just Megabyte
      it "1073741824 bytes should return Gigabyte" do
        let gb = getSizeUnit 1073741824.0
        gb `shouldEqual` Just Gigabyte
      it "1099511627776 bytes should return Terabyte" do
        let tb = getSizeUnit 1099511627776.0
        tb `shouldEqual` Just Terabyte
      it "negative number should return Nothing" do
        let n = getSizeUnit (-1000.0)
        n `shouldEqual` Nothing
    describe "getHumanSize" do
      it "1023 bytes should return 1023.0 bytes" do
        let hBytes = getHumanSize 1023.0
        hBytes `shouldEqual` "1023.0 bytes"
      it "1024 bytes should return 1.0 kb" do
        let kBytes = getHumanSize 1024.0
        kBytes `shouldEqual` "1.0 kb"
      it "1048576 bytes should return 1.0 mb" do
        let mBytes = getHumanSize 1048576.0
        mBytes `shouldEqual` "1.0 mb"
      it "1073741824 bytes should return 1.0 gb" do
        let gBytes = getHumanSize 1073741824.0
        gBytes `shouldEqual` "1.0 gb"
      it "1099511627776 bytes should return 1.0 tb" do
        let tBytes = getHumanSize 1099511627776.0
        tBytes `shouldEqual` "1.0 tb"
