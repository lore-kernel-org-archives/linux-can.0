From: GeoffO <geoffeolson@gmail.com>
Subject: Trying to use ESD CAN-USB with SocketCAN
Date: Thu, 28 Feb 2013 17:57:53 +0000 (UTC)
Message-ID: <loom.20130228T180224-395@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:49915 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752610Ab3B1SEq (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 28 Feb 2013 13:04:46 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1UB7qq-0001KF-Ex
	for linux-can@vger.kernel.org; Thu, 28 Feb 2013 19:05:04 +0100
Received: from c-98-246-44-194.hsd1.or.comcast.net ([98.246.44.194])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 28 Feb 2013 19:05:04 +0100
Received: from geoffeolson by c-98-246-44-194.hsd1.or.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 28 Feb 2013 19:05:04 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

I wanted to setup SocketCAN on my PC to prepare for an embedded Linux project,
so I purchased a USB device from ESD who claimed it supports SocketCAN.
I could not get it to work after the following these steps: 
Downloaded and installed can-utils
Loaded modules to the kernal
	sudo modprobe can
	sudo modprobe can_raw
	sudo modprobe can_bcm
	sudo modprobe vcan

Checked that modules are loaded
	lsmod | grep can
	vcan                    1314  0 
	can_bcm                11942  0 
	can_raw                 5381  0 
	can                    21728  2 can_bcm,can_raw

Plugged-in ESD CAN-USB/Micro and got this new device
	/dev/ttyACM0

Tried to attach the USB device to SocketCAN
	sudo slcan_attach /dev/ttyACM0
	ioctl TIOCSETD: Invalid argument

I got this error, so I checked the code of slcan_attach to find the problem,
and wrote this small program to isolate the problem:

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#define LDISC_N_SLCAN 17 // default slcan line discipline since Kernel 2.6.25
int main(int argc, char **argv)
{
	int fd;
	int ldisc = LDISC_N_SLCAN;
	char *tty = "/dev/ttyACM0";//device for ESD CAN/USB Micro
	if ((fd = open (tty, O_WRONLY | O_NOCTTY)) < 0) {
		perror(tty);
		exit(1);
	}
	// set slcan line discipline on given tty
	if (ioctl (fd, TIOCSETD, &ldisc) < 0) {
		perror("ioctl TIOCSETD");
		exit(1);
	}
	return 0;
}

This program writes "ioctl TIOCSETD: Invalid argument" to the consul.  The
problem is apparently caused when ioctl() tries to set the LDISC_N_SLCAN line
discipline for /dev/ttyACM0 and detects an invalid argument.  I tried setting
the line discipline to N_TTY and it did not complain.  I am running Ubuntu
10.04 with kernal version 2.6.32.  Any Idea what might be the problem?  
Is this device supported by by SocketCAN?  ESD claims it is.



