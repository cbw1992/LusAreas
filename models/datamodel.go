package models

import "time"

type DateInfo struct {
	DateId      int64     `bson:dateid`
	Date        time.Time `bson:"date"`
	Week        int64     `bson:"week"`
	MonthId     int64     `bson:"monthid"`
	MonthDesc   string    `bson:"monthdesc"`
	MonthName   string    `bson:monthname`
	QuarterId   int64     `bson:"quarterid"`
	QuarterDesc string    `bson:"quarterdesc"`
	QuarterName string    `bson:"quartername"`
	Year        int64     `bson:"year"`
}
