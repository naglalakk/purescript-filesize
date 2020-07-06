purescript-filesize
===

Simple utils for filesizes

### Example

Get a human readable string for 1mb (1048567 bytes)

    > import FileSize (getHumanSize)
    > getHumanSize 1048567.0
    "1.0 mb"

Get the SizeUnit for 1024 bytes

    > import FileSize (getSizeUnit)
    > getSizeUnit 1024.0
    Just Kilobyte
