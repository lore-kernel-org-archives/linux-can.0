From: Leo Stan <leo.stanislas@qut.edu.au>
Subject: Re: kvaser leaf and SocketCAN
Date: Thu, 30 Apr 2015 06:14:35 +0000 (UTC)
Message-ID: <loom.20150430T080326-120@post.gmane.org>
References: <loom.20150422T090300-352@post.gmane.org> <553755E8.20704@pengutronix.de> <loom.20150429T040002-878@post.gmane.org> <CANGgnMbtZz2M=-7ydV6iSFtCskTeXnKsWVB9rqnwX1M+SE1AAg@mail.gmail.com> <loom.20150429T063429-693@post.gmane.org> <55406A03.9060105@pengutronix.de> <20150429104528.GA5712@linux> <loom.20150430T051006-395@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:39360 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750705AbbD3GOu (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 30 Apr 2015 02:14:50 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1YnhkF-0001bb-6M
	for linux-can@vger.kernel.org; Thu, 30 Apr 2015 08:14:47 +0200
Received: from nocproxy03-b.net.qut.edu.au ([131.181.251.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 30 Apr 2015 08:14:47 +0200
Received: from leo.stanislas by nocproxy03-b.net.qut.edu.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 30 Apr 2015 08:14:47 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org


Actually I spoke too soon...

When I try this simple code from the documentation :


#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
 
#include <net/if.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
 
#include <linux/can.h>
#include <linux/can/raw.h>
 
int main(void)
{
	int s;
	int nbytes;
	struct sockaddr_can addr;
	struct can_frame frame;
	struct ifreq ifr;
 
	char *ifname = "can0";
 
	if((s = socket(PF_CAN, SOCK_RAW, CAN_RAW)) < 0) {
		perror("Error while opening socket");
		return -1;
	}
 
	strcpy(ifr.ifr_name, ifname);
	ioctl(s, SIOCGIFINDEX, &ifr);
 
	addr.can_family  = AF_CAN;
	addr.can_ifindex = ifr.ifr_ifindex; 
 
	printf("%s at index %d\n", ifname, ifr.ifr_ifindex);
 
	if(bind(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
		perror("Error in socket bind");
		return -2;
	}

	// Reading the CAN port


	nbytes=read(s,&frame,sizeof(struct can_frame));

	if (nbytes < 0) {
            perror("can raw socket read");
            return 1;
        }

        /* paranoid check ... */
        if (nbytes < sizeof(struct can_frame)) {
            fprintf(stderr, "read: incomplete CAN frame\n");
            return 1;
        }

        printf("dlc = %d, data = %s, %d bytes read\n", 
frame.can_dlc,frame.data,nbytes);

        close(s);
	
        return 0;
}

I get this flag :

can0 at index 3
can raw socket read: Network is down



Which means that nothing has been read from the CAN I guess, however I'm 
sure that data comes from it because I can see it using CANking software on 
Windows.

When I run "ifconfig -a"  RX and TX are also empty:

can0      Link encap:UNSPEC  HWaddr 00-00-00-00-00-00-00-00-00-00-00-00-00-
00-00-00  
          NOARP  MTU:16  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:10 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)


Here are the settings of my BUS on Canking :

No init access
Speed : 500000 Bit/s
Bit timing : Q=8, S1=5,S2=3,Sampling point= 62.5%, SJW=1
DLC = 8

Any help would be really appreciated



