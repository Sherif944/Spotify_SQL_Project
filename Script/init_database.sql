/*
===============
Create Database
===============
Script Purpose:
This script creates a new database named 'SpotifyDB' after checking if it already exists. 
If the database exists, it is dropped and recreated.
WARNING: 
Running this script will drop the entire 'SpotifyDB' database if it exists. 
All data in the database will be permanently deleted. Proceed with caution 
and ensure you have proper backups before running this script.
*/

-- Create database SpotifyDB

IF EXISTS(SELECT 1 FROM sys.databases WHERE NAME = 'SpotifyDB')
BEGIN
	ALTER DATABASE SpotifyDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE SpotifyDB
END;
GO
CREATE DATABASE SpotifyDB;
GO
USE SpotifyDB;

