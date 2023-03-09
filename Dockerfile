FROM surrealdb/surrealdb:1.0.0-beta.8
EXPOSE 8000
CMD ["start", "--bind", "0.0.0.0:8000", "file://data/srdb.db"]
