From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: reading from socket can
Date: Fri, 28 Jul 2017 21:26:33 +0200
Message-ID: <6ea8486b-f87c-566d-6a1a-10ef451d6574@hartkopp.net>
References: <alpine.LNX.2.21.1707271530280.9093@mpslxdressel.desy.de>
 <492e6c1e-efad-155d-4557-bf8ce1a1cec0@hartkopp.net>
 <alpine.LNX.2.21.1707280839520.1663@mpslxdressel.desy.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------61D392AB59F8411E7BFA81E7"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:36003 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752385AbdG1T0f (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 28 Jul 2017 15:26:35 -0400
In-Reply-To: <alpine.LNX.2.21.1707280839520.1663@mpslxdressel.desy.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Dressel <michael.dressel@desy.de>
Cc: linux-can@vger.kernel.org

This is a multi-part message in MIME format.
--------------61D392AB59F8411E7BFA81E7
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael,

On 07/28/2017 09:01 AM, Michael Dressel wrote:

> Here is just some code, that is similar to what happens in the
> driver we use:
> 
> nread = read(can_fd, &rx[0], sizeof(struct can_frame) * 10);
>      if (nread > 0) {
>          int i;

If you wanted to check whether only 'correct & complete' struct 
can_frames have been read from the socket at least this should be done:

	if (nread % sizeof(struct can_frame))
		exit(1); // or something like this ;-)

 >          nread = nread / sizeof(struct can_frame);
>              for (i = 0; i < nread; i++) {
> 

I was really unsure if

	nread = read(can_fd, &rx[0], sizeof(struct can_frame) * 10);

makes sense at all - and nread would ever be greater than 1 ?!?

I modified https://github.com/linux-can/can-tests/blob/master/tst-raw.c 
to get a similar setup (diff for tst-raw.c is attached):

while (1) {
    if ((nbytes = read(s, &frame[0], 10*sizeof(struct can_frame))) < 0) {
         perror("read");
         if (!ignore_errors)
              return 1;
    } else if (nbytes % sizeof(struct can_frame)) {
         fprintf(stderr, "read: incomplete CAN frame\n");
         return 1;
    } else {
         for (k=0; k < nbytes / sizeof(struct can_frame); k++) {
              printf("<%d> ", k);

              if (k) exit(1); // see remark below

              if (frame[0].can_id & CAN_EFF_FLAG)
                     printf("%8X  ", frame[0].can_id & CAN_EFF_MASK);

(..)

I tested this patch an NEVER got more than ONE single CAN frame per 
read(). Then I added the brutal

	if (k) exit(1);

check to not miss any attempt of more than one CAN frame - but it did 
not occur ...

So I think your provided code does not have the functionality the 
programmer intended.

If you want to make sure that no frame was dropped in the socket's 
receive queue take a look at this:

http://marc.info/?l=linux-can&m=147929028915128&w=2

Additionally you might increase the RX buffer size of the socket with 
the SO_RCVBUF socket option:

https://github.com/linux-can/can-utils/blob/master/candump.c#L525

There are some examples how to use the Linux specific 'multiple read' 
system calls:

http://rtime.felk.cvut.cz/can/
http://rtime.felk.cvut.cz/can/can-syscalls.pdf

But finally I would just use recvmsg() and check for the dropcount value 
to check whether you have a problem at all.

Best,
Oliver


> I was not able to provoke my issues in a controlled test environment.
> 
> And in the productive environment it occurs only about every 3 to 5 weeks.
> 
> Cheers,
> Michael

--------------61D392AB59F8411E7BFA81E7
Content-Type: text/x-patch;
 name="multiread.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="multiread.diff"

diff --git a/tst-raw.c b/tst-raw.c
index 1e0284b..0e5c2a9 100644
--- a/tst-raw.c
+++ b/tst-raw.c
@@ -59,8 +59,8 @@ int main(int argc, char **argv)
 	int s;
 	struct sockaddr_can addr;
 	struct can_filter rfilter[4];
-	struct can_frame frame;
-	int nbytes, i;
+	struct can_frame frame[10];
+	int nbytes, i, k;
 	struct ifreq ifr;
 	char *ifname = "vcan2";
 	int ifindex;
@@ -142,38 +142,44 @@ int main(int argc, char **argv)
 
 	if(send_one_frame) {
 
-		frame.can_id  = 0x123;
-		frame.can_dlc = 2;
-		frame.data[0] = 0x11;
-		frame.data[1] = 0x22;
+		frame[0].can_id  = 0x123;
+		frame[0].can_dlc = 2;
+		frame[0].data[0] = 0x11;
+		frame[0].data[1] = 0x22;
 
-		nbytes = write(s, &frame, sizeof(struct can_frame));
+		nbytes = write(s, &frame[0], sizeof(struct can_frame));
 	}
 
 	while (1) {
 
-		if ((nbytes = read(s, &frame, sizeof(struct can_frame))) < 0) {
+		if ((nbytes = read(s, &frame[0], 10*sizeof(struct can_frame))) < 0) {
 			perror("read");
 			if (!ignore_errors)
 				return 1;
-		} else if (nbytes < sizeof(struct can_frame)) {
+		} else if (nbytes % sizeof(struct can_frame)) {
 			fprintf(stderr, "read: incomplete CAN frame\n");
 			return 1;
 		} else {
-			if (frame.can_id & CAN_EFF_FLAG)
-				printf("%8X  ", frame.can_id & CAN_EFF_MASK);
-			else
-				printf("%3X  ", frame.can_id & CAN_SFF_MASK);
+			for (k=0; k < nbytes / sizeof(struct can_frame); k++) {
+				printf("<%d> ", k);
+
+				if (k) exit(1);
+
+				if (frame[0].can_id & CAN_EFF_FLAG)
+					printf("%8X  ", frame[0].can_id & CAN_EFF_MASK);
+				else
+					printf("%3X  ", frame[0].can_id & CAN_SFF_MASK);
 	    
-			printf("[%d] ", frame.can_dlc);
+				printf("[%d] ", frame[0].can_dlc);
 	    
-			for (i = 0; i < frame.can_dlc; i++) {
-				printf("%02X ", frame.data[i]);
+				for (i = 0; i < frame[0].can_dlc; i++) {
+					printf("%02X ", frame[0].data[i]);
+				}
+				if (frame[0].can_id & CAN_RTR_FLAG)
+					printf("remote request");
+				printf("\n");
+				fflush(stdout);
 			}
-			if (frame.can_id & CAN_RTR_FLAG)
-				printf("remote request");
-			printf("\n");
-			fflush(stdout);
 		}
 	}
 

--------------61D392AB59F8411E7BFA81E7--
