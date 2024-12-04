(ns adventofcode.2024.03
  (:require [clojure.string :as str]))

(defn parse-mul [mul]
  (->> (apply list mul)
       (rest)
   	   (map parse-long)))

(defn parse-file [file]
  (map parse-mul (re-seq #"mul\((\d+),(\d+)\)" file)))

(def in (parse-file (slurp *in*)))

(defn f1 []
  (apply + (map #(apply * %) in)))

(defn f2 []
  ())

(println (f1))
