From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Flexcan - timestamp from message buffer to userspace
Date: Mon, 21 Oct 2013 18:29:20 +0200
Message-ID: <52655660.30100@hartkopp.net>
References: <l3r0ki$hde$1@ger.gmane.org> <526113A1.8020403@kkmicro.cz> <526148E9.4040406@hartkopp.net> <5264CFA6.9050805@kkmicro.cz> <07b96b822a3778b2279d78b90cda3908@grandegger.com> <9d0a209e86731f7a68f84dbdc52124cc@grandegger.com> <5264EBB9.3010803@kkmicro.cz> <5264F918.1050408@kkmicro.cz> <df0fb8a7e99577852c73a96a605465c5@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:23599 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305Ab3JUQ3e (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 21 Oct 2013 12:29:34 -0400
In-Reply-To: <df0fb8a7e99577852c73a96a605465c5@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Martin Kozusky <mkozusky@kkmicro.cz>
Cc: linux-can@vger.kernel.org

On 21.10.2013 13:23, Wolfgang Grandegger wrote:
> On Mon, 21 Oct 2013 11:51:20 +0200, Martin Kozusky <mkozusky@kkmicro.cz>


> 
>> When I do
> 
>>   ioctl(sock, SIOCSHWTSTAMP, &hwtstamp) it returns ENOTSUP :( do I have 
> 
>> to define this ioctl somehow in the flexcan driver or somewhere else?
> 
> 
> 
> Yes, it looks like. Doing an "identifier search" for SIOCSHWTSTAMP in
> 
> "http://lxr.free-electrons.com/source/" should list various drivers
> 
> implementing that request.
> 

Hi Martin,

if you want to configure the selection of available timestamps, there needs
to be implemented something in the driver itself.

E.g. if a network driver supports filtering for special packet types to send
the timestamps only for these packets, it need to present it's capabilities
and also needs to implement the existing configuration API.

E.g. if you say:
# ethtool -T can0
Time stamping parameters for can0:
Capabilities:
	software-receive      (SOF_TIMESTAMPING_RX_SOFTWARE)
	software-system-clock (SOF_TIMESTAMPING_SOFTWARE)
PTP Hardware Clock: none
Hardware Transmit Timestamp Modes: none
Hardware Receive Filter Modes: none

This is the output from my SJA1000 based EMS PCMCIA card.
But for the software device vcan0 it's the same.

From what i get from this interface is only software timestamps.

I played with candump yesterday:

diff --git a/candump.c b/candump.c
index c865bd7..44a59b2 100644
--- a/candump.c
+++ b/candump.c
@@ -60,6 +60,7 @@
 
 #include <linux/can.h>
 #include <linux/can/raw.h>
+#include <linux/net_tstamp.h>
 
 #include "terminal.h"
 #include "lib.h"
@@ -537,6 +538,7 @@ int main(int argc, char **argv)
 
 		if (timestamp || log || logfrmt) {
 
+#if 1
 			const int timestamp_on = 1;
 
 			if (setsockopt(s[i], SOL_SOCKET, SO_TIMESTAMP,
@@ -544,6 +546,17 @@ int main(int argc, char **argv)
 				perror("setsockopt SO_TIMESTAMP");
 				return 1;
 			}
+#endif
+#if 1
+//			const int timestamping_flags = ( SOF_TIMESTAMPING_RX_SOFTWARE |  SOF_TIMESTAMPING_RX_HARDWARE |  SOF_TIMESTAMPING_SOFTWARE);
+			const int timestamping_flags = ( SOF_TIMESTAMPING_RX_SOFTWARE |  SOF_TIMESTAMPING_SOFTWARE);
+
+			if (setsockopt(s[i], SOL_SOCKET, SO_TIMESTAMPING,
+				       &timestamping_flags, sizeof(timestamping_flags)) < 0) {
+				perror("setsockopt SO_TIMESTAMPING");
+				return 1;
+			}
+#endif
 		}
 
 		if (dropmonitor) {
@@ -664,10 +677,36 @@ int main(int argc, char **argv)
 				for (cmsg = CMSG_FIRSTHDR(&msg);
 				     cmsg && (cmsg->cmsg_level == SOL_SOCKET);
 				     cmsg = CMSG_NXTHDR(&msg,cmsg)) {
-					if (cmsg->cmsg_type == SO_TIMESTAMP)
+					if (cmsg->cmsg_type == SO_TIMESTAMP) {
+						printf("SO_TIMESTAMP\n");
 						tv = *(struct timeval *)CMSG_DATA(cmsg);
-					else if (cmsg->cmsg_type == SO_RXQ_OVFL)
+					} else if (cmsg->cmsg_type == SO_TIMESTAMPNS) {
+						printf("SO_TIMESTAMPNS\n");
+						tv = *(struct timeval *)CMSG_DATA(cmsg);
+					} else if (cmsg->cmsg_type == SO_TIMESTAMPING) {
+
+						struct timespec *stamp = (struct timespec *)CMSG_DATA(cmsg);
+
+						printf("SO_TIMESTAMPING\n");
+						tv = *(struct timeval *)CMSG_DATA(cmsg);
+
+						printf("SW %lu.%09lu ",
+						       (long)stamp->tv_sec,
+						       (long)stamp->tv_nsec);
+						stamp++;
+						printf("HW transformed %lu.%09lu ",
+						       (long)stamp->tv_sec,
+						       (long)stamp->tv_nsec);
+						stamp++;
+						printf("HW raw %lu.%09lu",
+						       (long)stamp->tv_sec,
+						       (long)stamp->tv_nsec);
+						printf("\n");
+
+					} else if (cmsg->cmsg_type == SO_RXQ_OVFL) {
+						printf("SO_RXQ_OVFL\n");
 						dropcnt[i] = *(__u32 *)CMSG_DATA(cmsg);
+					} else printf("cmsg->cmsg_type = %d\n", cmsg->cmsg_type);
 				}
 
 				/* check for (unlikely) dropped frames on this specific socket */



   

The problem is, when i set both SO_TIMESTAMP AND SO_TIMESTAMPING i get trash
in the SO_TIMESTAMPING values.

When I set either SO_TIMESTAMP OR SO_TIMESTAMPING i can see a good and valid
software timestamp. (compared with an unmodified candump).

Any idea about that?

Best regards,
Oliver

