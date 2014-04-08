(͡ ° ͜ʖ͡°) Simple Reddit Crawler
================================

Lightweight Reddit crawler using Python and MySQL

### How to build

1. `git clone` this repository.

2. Start mysql using `mysqld start`

3. Run the `create-database.sql` script in your mysql instance

4. Install Python pip using `sudo apt-get install python-pip`

5. Install PyMySQL using `sudo pip install PyMySQL`

6. Open `reader/reader.py`, search for `userAgent = ""` and enter an User-Agent there. Skipping this step will cause Reddit to block your requests.

### How to use the Crawler

The crawler runs in 2 steps: threads and comments.

##### Threads:

1. Run `python reader/reader.py /r/yoursubreddithere`

2. The script reads all the new threads in your subreddit of choice. Reddit limits /new to 25 threads, so only 25 threads are read at a time.

3. Then, it inserts all the threads found in the "threads" table.

4. By checking the ID of the thread given by Reddit (thread_id column in our "threads" table), we detect if that thread has already been read. Duplicate threads are ignored.

##### Comments:

1. Run `python reader/reader.py --get-comments`

2. The script loops through all the threads stored in the "threads" table and makes one json request for the comments of each thread.

3. Inserts all the comments in the "comments" table.

4. By checking the ID of the comment given by Reddit (comment_id column in our "comments" table), we detect if that comment has already been read. Duplicate comments are ignored.

##### Important:

Since Reddit limits the number of json requests to one every two seconds, the process of reading comments becomes increasingly long as more and more threads are posted. This ends up making the coments reading take so long that more than 25 threads are posted in the meantime, making us lose some threads.

To avoid this, we need to first read all the threads during a certain period of time and only after all the threads are in the database, we read their comments.

To do that, run `python reader/reader.py /r/yoursubreddithere` to store only the new threads. Leave this script running for as long as you need.

Then, stop it and run `python reader/reader.py --get-comments` to store only the comments from the threads read above. Note that this script will run repeatedly to get new comments, so stop its execution when enough comments have been captured.

You can check the result of each run in the `logs` table.