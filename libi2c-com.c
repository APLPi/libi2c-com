#include <stdio.h>
#include <sys/ioctl.h>
#include <linux/i2c-dev.h>
#include <linux/i2c.h>
#include <fcntl.h>
#include <errno.h>
#include <unistd.h>

static int fd = -1;

int OpenI2C(int bus, int extra_open_flags, int *err)
{
	char	fName[16];
	snprintf(fName,16,"/dev/i2c-%d",bus);
	
	if (-1 == (fd = open(fName,O_RDWR|extra_open_flags)))
	{
		*err = errno;
		return -1;
	}
	
	return 0;
}

int CloseI2C(int *err)
{
	if (-1 == close(fd))
	{
		*err = errno;
		return -1;
	}
	
	return 0;
}

int WriteBytes(int address, unsigned char bytes[256], int *err)
{
    struct i2c_rdwr_ioctl_data ioctl_arg;
    struct i2c_msg messages[1];

    messages[0].addr  = address;
    messages[0].flags = 0;
	messages[0].len   = sizeof(unsigned char) * bytes[0];	// bytes is a counted array
    messages[0].buf   = bytes + 1;							// ignore the first element

    ioctl_arg.msgs  = messages;
    ioctl_arg.nmsgs = 1;
	
	if(ioctl(fd, I2C_RDWR, &ioctl_arg) < 0)
	{
		*err = errno;
		return -1;
	}
	
	return 0;	
}

int ReadBytes(int address, unsigned char bytes[256], int *err)
{
    struct i2c_rdwr_ioctl_data ioctl_arg;
    struct i2c_msg messages[1];

    messages[0].addr  = address;
    messages[0].flags = I2C_M_RD;
    messages[0].len   = sizeof(unsigned char) * bytes[0];	// bytes is a counted array
    messages[0].buf   = bytes;								// include first element as we're receiving data

    ioctl_arg.msgs		= messages;
    ioctl_arg.nmsgs		= 1;
	
    if(ioctl(fd, I2C_RDWR, &ioctl_arg) < 0)
	{
		*err = errno;
		return -1;
    }
	
	return 0;
}
