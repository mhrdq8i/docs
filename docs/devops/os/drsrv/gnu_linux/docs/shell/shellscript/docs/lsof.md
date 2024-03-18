| Column |  Description |
| -- | -- |
| **COMMAND** | The first nine characters of the name of the command in the process |
| **PID** | The process ID of the process |
| **USER** | The login name of the user who owns the process |
| **FD** | The file descriptor number and access type (r - read, w - write, u - read/write) |
| **TYPE** | The type of file (CHR - character, BLK - block, DIR - directory, REG - regular file) |
| **DEVICE** | The device numbers (major and minor) of the device |
| **SIZE** | If available, the size of the file |
| **NODE** | The inode number of the local file |
| **NAME** | The name of the file |

---

## Example:
- lsof -a -p $$ -d 0,1,2
    - **-a:** means *and* conditions together
    - **-p:** lsof condition over the specific process
    - **-d:** select some file discriptior