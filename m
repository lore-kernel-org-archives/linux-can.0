From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: About timestamping and can-utils
Date: Thu, 06 Mar 2014 10:56:17 +0100
Message-ID: <53184641.1040506@hartkopp.net>
References: <53183F0E.7050309@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090806090104030209050501"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:49204 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908AbaCFJ40 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Mar 2014 04:56:26 -0500
In-Reply-To: <53183F0E.7050309@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is a multi-part message in MIME format.
--------------090806090104030209050501
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Hi Stephane,

here's a discussion thread from last year focussing HW timestamping:

http://marc.info/?l=linux-can&m=138210737431112&w=2

Additionally I attached two patches:

cants-test.patch:
added some functionality to add a monotonic (sw) timestamp to sja1000

candump-hwts.patch:
added some functionality to candump to get these timestamps

The candump patch is from the time before the include file cleanup inside the
can-utils provided by Uwe. (including from socketcan directory)

Together with the discussion thread from above, this should give a good
starting point.

Regards,
Oliver


On 06.03.2014 10:25, Stephane Grosjean wrote:
> Hi linux-can team,
> 
> I've got one question about how timestamping is done now in linux-can,
> regarding to HW timestamps.
> 
> In the early ages (~v3.4), the CAN hardware driver could set the timestamp of
> an skb by itself and push it with the received CAN frame, so that the
> application could get it using SO_TIMESTAMP socket option, right?
> Now, this "hardware" timestamp is to be copied into "hwstamp" field of the
> "skb_hwtstamps(skb)" area.
> 
> But how does user application manage to get this hardware timestamp on its
> side? AFAIK, the "candump" can-utils utility always reads and displays the
> "network" timestamp (that is, always uses SO_TIMESTAMP socket option). I had a
> quick look to the Kernel sources and tried to find the links between things
> but it's not very clear to me: first idea I tested was to set the
> SO_TIMESTAMPING socket option, but candump never received any hw timestamp in
> the control messages he reads from the CAN socket...
> 
> Any help would be appreciated.
> 
> Regards,
> 
> Stéphane
> -- 
> PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt
> Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt HRB-9183
> Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391 Tel.+49
> (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
> -- 

--------------090806090104030209050501
Content-Type: text/x-diff;
 name="cants-test.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cants-test.patch"

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index 7164a99..57b5d44 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -326,6 +326,8 @@ static void sja1000_rx(struct net_device *dev)
 	struct net_device_stats *stats = &dev->stats;
 	struct can_frame *cf;
 	struct sk_buff *skb;
+	struct timespec tsraw, tsreal;
+	struct skb_shared_hwtstamps *hwts;
 	uint8_t fi;
 	uint8_t dreg;
 	canid_t id;
@@ -366,6 +368,11 @@ static void sja1000_rx(struct net_device *dev)
 	/* release receive buffer */
 	sja1000_write_cmdreg(priv, CMD_RRB);
 
+	getnstime_raw_and_real(&tsraw, &tsreal);
+	skb->tstamp = timespec_to_ktime(tsreal);
+	hwts = skb_hwtstamps(skb);
+	hwts->syststamp = timespec_to_ktime(tsraw);
+
 	netif_rx(skb);
 
 	stats->rx_packets++;
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 947ba25..19fc013 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -431,8 +431,6 @@ ktime_t ktime_get_clocktai(void)
 }
 EXPORT_SYMBOL(ktime_get_clocktai);
 
-#ifdef CONFIG_NTP_PPS
-
 /**
  * getnstime_raw_and_real - get day and raw monotonic time in timespec format
  * @ts_raw:	pointer to the timespec to be set to raw monotonic time
@@ -467,8 +465,6 @@ void getnstime_raw_and_real(struct timespec *ts_raw, struct timespec *ts_real)
 }
 EXPORT_SYMBOL(getnstime_raw_and_real);
 
-#endif /* CONFIG_NTP_PPS */
-
 /**
  * do_gettimeofday - Returns the time of day in a timeval
  * @tv:		pointer to the timeval to be set

--------------090806090104030209050501
Content-Type: text/x-diff;
 name="candump-hwts.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="candump-hwts.patch"

diff --git a/Makefile b/Makefile
index 2f79ee7..40067fb 100644
--- a/Makefile
+++ b/Makefile
@@ -45,6 +45,7 @@ MAKEFLAGS = -k
 
 CFLAGS    = -O2 -Wall -Wno-parentheses -Iinclude \
 	    -fno-strict-aliasing \
+	    -DSO_TIMESTAMPING=37 \
 	    -DSO_RXQ_OVFL=40 \
 	    -DPF_CAN=29 \
 	    -DAF_CAN=PF_CAN
diff --git a/candump.c b/candump.c
index c865bd7..d7723d8 100644
--- a/candump.c
+++ b/candump.c
@@ -60,6 +60,7 @@
 
 #include <linux/can.h>
 #include <linux/can/raw.h>
+#include <linux/net_tstamp.h>
 
 #include "terminal.h"
 #include "lib.h"
@@ -106,7 +107,8 @@ void print_usage(char *prg)
 {
 	fprintf(stderr, "\nUsage: %s [options] <CAN interface>+\n", prg);
 	fprintf(stderr, "  (use CTRL-C to terminate %s)\n\n", prg);
-	fprintf(stderr, "Options: -t <type>   (timestamp: (a)bsolute/(d)elta/(z)ero/(A)bsolute w date)\n");
+	fprintf(stderr, "Options: -t <type>   (timestamp: (a)bsolute/(d)elta/(z)ero/(A)bsolute w date )\n");
+	fprintf(stderr, "                     (           (r)aw hardware/(s)ystem hardware transformed)\n");
 	fprintf(stderr, "         -c          (increment color mode level)\n");
 	fprintf(stderr, "         -i          (binary output - may exceed 80 chars/line)\n");
 	fprintf(stderr, "         -a          (enable additional ASCII output)\n");
@@ -219,7 +221,10 @@ int main(int argc, char **argv)
 	int currmax, numfilter;
 	char *ptr, *nptr;
 	struct sockaddr_can addr;
-	char ctrlmsg[CMSG_SPACE(sizeof(struct timeval)) + CMSG_SPACE(sizeof(__u32))];
+	struct {
+		struct cmsghdr cm;
+		char control[512];
+	} control;
 	struct iovec iov;
 	struct msghdr msg;
 	struct cmsghdr *cmsg;
@@ -228,7 +233,8 @@ int main(int argc, char **argv)
 	struct canfd_frame frame;
 	int nbytes, i, maxdlen;
 	struct ifreq ifr;
-	struct timeval tv, last_tv;
+	struct timespec *stamp;
+	static struct timeval tv, last_tv;
 	struct timeval timeout, timeout_config = { 0, 0 }, *timeout_current = NULL;
 	FILE *logfile = NULL;
 
@@ -244,6 +250,7 @@ int main(int argc, char **argv)
 		case 't':
 			timestamp = optarg[0];
 			if ((timestamp != 'a') && (timestamp != 'A') &&
+			    (timestamp != 'r') && (timestamp != 's') &&
 			    (timestamp != 'd') && (timestamp != 'z')) {
 				fprintf(stderr, "%s: unknown timestamp mode '%c' - ignored\n",
 				       basename(argv[0]), optarg[0]);
@@ -537,12 +544,30 @@ int main(int argc, char **argv)
 
 		if (timestamp || log || logfrmt) {
 
-			const int timestamp_on = 1;
+			if ((timestamp != 'r') && (timestamp != 's')) {
 
-			if (setsockopt(s[i], SOL_SOCKET, SO_TIMESTAMP,
-				       &timestamp_on, sizeof(timestamp_on)) < 0) {
-				perror("setsockopt SO_TIMESTAMP");
-				return 1;
+				const int timestamp_on = 1;
+
+				if (setsockopt(s[i], SOL_SOCKET, SO_TIMESTAMP,
+					       &timestamp_on, sizeof(timestamp_on)) < 0) {
+					perror("setsockopt SO_TIMESTAMP");
+					return 1;
+				}
+			} else {
+
+//				int timestamping_flags = (SOF_TIMESTAMPING_RX_SOFTWARE | SOF_TIMESTAMPING_SOFTWARE | SOF_TIMESTAMPING_RX_HARDWARE);
+				int timestamping_flags = (SOF_TIMESTAMPING_SOFTWARE | SOF_TIMESTAMPING_RX_HARDWARE);
+
+				if (timestamp == 'r')
+					timestamping_flags |= SOF_TIMESTAMPING_RAW_HARDWARE;
+				else
+					timestamping_flags |= SOF_TIMESTAMPING_SYS_HARDWARE;
+
+				if (setsockopt(s[i], SOL_SOCKET, SO_TIMESTAMPING,
+					       &timestamping_flags, sizeof(timestamping_flags)) < 0) {
+					perror("setsockopt SO_TIMESTAMPING");
+					return 1;
+				}
 			}
 		}
 
@@ -600,7 +625,7 @@ int main(int argc, char **argv)
 	msg.msg_name = &addr;
 	msg.msg_iov = &iov;
 	msg.msg_iovlen = 1;
-	msg.msg_control = &ctrlmsg;
+	msg.msg_control = &control;
 
 	while (running) {
 
@@ -626,7 +651,7 @@ int main(int argc, char **argv)
 				/* these settings may be modified by recvmsg() */
 				iov.iov_len = sizeof(frame);
 				msg.msg_namelen = sizeof(addr);
-				msg.msg_controllen = sizeof(ctrlmsg);  
+				msg.msg_controllen = sizeof(control);
 				msg.msg_flags = 0;
 
 				nbytes = recvmsg(s[i], &msg, 0);
@@ -664,10 +689,48 @@ int main(int argc, char **argv)
 				for (cmsg = CMSG_FIRSTHDR(&msg);
 				     cmsg && (cmsg->cmsg_level == SOL_SOCKET);
 				     cmsg = CMSG_NXTHDR(&msg,cmsg)) {
-					if (cmsg->cmsg_type == SO_TIMESTAMP)
+
+					switch (cmsg->cmsg_type) {
+
+					case SO_TIMESTAMP:
+						printf("SO_TIMESTAMP\n");
 						tv = *(struct timeval *)CMSG_DATA(cmsg);
-					else if (cmsg->cmsg_type == SO_RXQ_OVFL)
+						break;
+
+					case SO_TIMESTAMPING:
+						stamp = (struct timespec *)CMSG_DATA(cmsg);
+						printf("SO_TIMESTAMPING\n");
+
+						if (timestamp == 'r') {
+							tv.tv_sec = (stamp + 2)->tv_sec;
+							tv.tv_usec = (stamp + 2)->tv_nsec/1000;
+						} else {
+							tv.tv_sec = (stamp + 1)->tv_sec;
+							tv.tv_usec = (stamp + 1)->tv_nsec/1000;
+						}
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
+						break;
+
+					case SO_RXQ_OVFL:
+						printf("SO_RXQ_OVFL\n");
 						dropcnt[i] = *(__u32 *)CMSG_DATA(cmsg);
+						break;
+
+					default:
+						printf("unknown cmsg_type = %d\n", cmsg->cmsg_type);
+					}
 				}
 
 				/* check for (unlikely) dropped frames on this specific socket */
@@ -726,6 +789,8 @@ int main(int argc, char **argv)
 				switch (timestamp) {
 
 				case 'a': /* absolute with timestamp */
+				case 'r': /* absolute with raw hardware timestamp */
+				case 's': /* absolute with system hardware transformed timestamp */
 					printf("(%010ld.%06ld) ", tv.tv_sec, tv.tv_usec);
 					break;
 
diff --git a/include/linux/net_tstamp.h b/include/linux/net_tstamp.h
index e69de29..a8724a7 100644
--- a/include/linux/net_tstamp.h
+++ b/include/linux/net_tstamp.h
@@ -0,0 +1 @@
+#include <socketcan/net_tstamp.h>
diff --git a/include/socketcan/net_tstamp.h b/include/socketcan/net_tstamp.h
index e69de29..ae5df12 100644
--- a/include/socketcan/net_tstamp.h
+++ b/include/socketcan/net_tstamp.h
@@ -0,0 +1,113 @@
+/*
+ * Userspace API for hardware time stamping of network packets
+ *
+ * Copyright (C) 2008,2009 Intel Corporation
+ * Author: Patrick Ohly <patrick.ohly@intel.com>
+ *
+ */
+
+#ifndef _NET_TIMESTAMPING_H
+#define _NET_TIMESTAMPING_H
+
+#include <linux/socket.h>   /* for SO_TIMESTAMPING */
+
+/* SO_TIMESTAMPING gets an integer bit field comprised of these values */
+enum {
+	SOF_TIMESTAMPING_TX_HARDWARE = (1<<0),
+	SOF_TIMESTAMPING_TX_SOFTWARE = (1<<1),
+	SOF_TIMESTAMPING_RX_HARDWARE = (1<<2),
+	SOF_TIMESTAMPING_RX_SOFTWARE = (1<<3),
+	SOF_TIMESTAMPING_SOFTWARE = (1<<4),
+	SOF_TIMESTAMPING_SYS_HARDWARE = (1<<5),
+	SOF_TIMESTAMPING_RAW_HARDWARE = (1<<6),
+	SOF_TIMESTAMPING_MASK =
+	(SOF_TIMESTAMPING_RAW_HARDWARE - 1) |
+	SOF_TIMESTAMPING_RAW_HARDWARE
+};
+
+/**
+ * struct hwtstamp_config - %SIOCSHWTSTAMP parameter
+ *
+ * @flags:	no flags defined right now, must be zero
+ * @tx_type:	one of HWTSTAMP_TX_*
+ * @rx_type:	one of one of HWTSTAMP_FILTER_*
+ *
+ * %SIOCSHWTSTAMP expects a &struct ifreq with a ifr_data pointer to
+ * this structure. dev_ifsioc() in the kernel takes care of the
+ * translation between 32 bit userspace and 64 bit kernel. The
+ * structure is intentionally chosen so that it has the same layout on
+ * 32 and 64 bit systems, don't break this!
+ */
+struct hwtstamp_config {
+	int flags;
+	int tx_type;
+	int rx_filter;
+};
+
+/* possible values for hwtstamp_config->tx_type */
+enum hwtstamp_tx_types {
+	/*
+	 * No outgoing packet will need hardware time stamping;
+	 * should a packet arrive which asks for it, no hardware
+	 * time stamping will be done.
+	 */
+	HWTSTAMP_TX_OFF,
+
+	/*
+	 * Enables hardware time stamping for outgoing packets;
+	 * the sender of the packet decides which are to be
+	 * time stamped by setting %SOF_TIMESTAMPING_TX_SOFTWARE
+	 * before sending the packet.
+	 */
+	HWTSTAMP_TX_ON,
+
+	/*
+	 * Enables time stamping for outgoing packets just as
+	 * HWTSTAMP_TX_ON does, but also enables time stamp insertion
+	 * directly into Sync packets. In this case, transmitted Sync
+	 * packets will not received a time stamp via the socket error
+	 * queue.
+	 */
+	HWTSTAMP_TX_ONESTEP_SYNC,
+};
+
+/* possible values for hwtstamp_config->rx_filter */
+enum hwtstamp_rx_filters {
+	/* time stamp no incoming packet at all */
+	HWTSTAMP_FILTER_NONE,
+
+	/* time stamp any incoming packet */
+	HWTSTAMP_FILTER_ALL,
+
+	/* return value: time stamp all packets requested plus some others */
+	HWTSTAMP_FILTER_SOME,
+
+	/* PTP v1, UDP, any kind of event packet */
+	HWTSTAMP_FILTER_PTP_V1_L4_EVENT,
+	/* PTP v1, UDP, Sync packet */
+	HWTSTAMP_FILTER_PTP_V1_L4_SYNC,
+	/* PTP v1, UDP, Delay_req packet */
+	HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ,
+	/* PTP v2, UDP, any kind of event packet */
+	HWTSTAMP_FILTER_PTP_V2_L4_EVENT,
+	/* PTP v2, UDP, Sync packet */
+	HWTSTAMP_FILTER_PTP_V2_L4_SYNC,
+	/* PTP v2, UDP, Delay_req packet */
+	HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ,
+
+	/* 802.AS1, Ethernet, any kind of event packet */
+	HWTSTAMP_FILTER_PTP_V2_L2_EVENT,
+	/* 802.AS1, Ethernet, Sync packet */
+	HWTSTAMP_FILTER_PTP_V2_L2_SYNC,
+	/* 802.AS1, Ethernet, Delay_req packet */
+	HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ,
+
+	/* PTP v2/802.AS1, any layer, any kind of event packet */
+	HWTSTAMP_FILTER_PTP_V2_EVENT,
+	/* PTP v2/802.AS1, any layer, Sync packet */
+	HWTSTAMP_FILTER_PTP_V2_SYNC,
+	/* PTP v2/802.AS1, any layer, Delay_req packet */
+	HWTSTAMP_FILTER_PTP_V2_DELAY_REQ,
+};
+
+#endif /* _NET_TIMESTAMPING_H */

--------------090806090104030209050501--
