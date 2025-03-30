--Based on the user_activity table, write a query to
--retrieve the time difference between each user's
--most recent event and their second-to-last event, sorted in ascending order by user_identifier.
use deliotte

-- Creare Table user_activity
CREATE TABLE user_activity (
    user_identifier INT,
    event_type VARCHAR(20),
    event_date DATE
);

-- Insert values
INSERT INTO user_activity (user_identifier, event_type, event_date) 
VALUES
(1, 'Login', '2023-05-10'),
(1, 'Logout', '2023-05-12'),
(2, 'Login', '2023-06-01'),
(2, 'Purchase', '2023-06-04'),
(3, 'Login', '2023-07-15'),
(3, 'Logout', '2023-07-16'),
(4, 'Login', '2023-08-20'),
(4, 'Purchase', '2023-08-25');
select * from user_activity
with event_ranked as(
select user_identifier,event_date, lag(event_date) over(partition by user_identifier order by event_date)as prev_event_date 
from user_activity)
select user_identifier,event_date-prev_event_date as days_elapsed
from event_ranked
where prev_event_date is not null
order by user_identifier 
