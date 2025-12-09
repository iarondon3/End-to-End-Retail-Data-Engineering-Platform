/* INITIALIZATION SCRIPT
   This script runs automatically when the containers start to ensure 
   the Citus extension is enabled on the Coordinator and all Workers.
*/

-- Switch to the target database
\connect coorddb

-- Enable the extension (Idempotent check)
CREATE EXTENSION IF NOT EXISTS citus;
