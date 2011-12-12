From: <kime-Z4QKGCRq86k@public.gmane.org>
Subject: RE: CAN State Information
Date: Mon, 12 Dec 2011 11:21:29 +0100
Message-ID: <166589D0B9DD2547A1319599B9BADA1FC62417@vsv-exchange.ixxat.intranet.priv>
References: <166589D0B9DD2547A1319599B9BADA1FC1960C@vsv-exchange.ixxat.intranet.priv>
	<4EDE342E.8030102@grandegger.com>
	<166589D0B9DD2547A1319599B9BADA1FC1981F@vsv-exchange.ixxat.intranet.priv>
	<4EE10CB4.2090604@grandegger.com>
	<166589D0B9DD2547A1319599B9BADA1FC19968@vsv-exchange.ixxat.intranet.priv>
	<4EE1C3BF.70104@grandegger.com> <4EE1C47A.7080507@grandegger.com>
	<166589D0B9DD2547A1319599B9BADA1FC1998A@vsv-exchange.ixxat.intranet.priv>
	<4EE1CE2B.6090909@grandegger.com>
	<166589D0B9DD2547A1319599B9BADA1FC19A38@vsv-exchange.ixxat.intranet.priv>
	<4EE2200E.4060403@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <socketcan-core-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <4EE2200E.4060403-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
List-Unsubscribe: <https://lists.berlios.de/mailman/options/socketcan-core>,
	<mailto:socketcan-core-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.berlios.de/pipermail/socketcan-core>
List-Post: <mailto:socketcan-core-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
List-Help: <mailto:socketcan-core-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=help>
List-Subscribe: <https://lists.berlios.de/mailman/listinfo/socketcan-core>,
	<mailto:socketcan-core-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=subscribe>
Sender: socketcan-core-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
Errors-To: socketcan-core-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
To: wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org
Cc: socketcan-core-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-can.vger.kernel.org

Here is the patch.  It polls for messages at the end of the loop and repeat=
s if needed.

diff -Naur b/libsocketcan.c a/libsocketcan.c
--- b/libsocketcan.c	2010-02-14 20:22:15.000000000 +0100
+++ a/libsocketcan.c	2011-12-12 11:10:40.000000000 +0100
@@ -32,6 +32,7 @@
 =

 #include <linux/rtnetlink.h>
 #include <linux/netlink.h>
+#include <poll.h>
 =

 #include <libsocketcan.h>
 =

@@ -322,6 +323,13 @@
 	char nlbuf[1024 * 8];
 =

 	int ret =3D -1;
+	int repeat =3D 0;
+
+	struct pollfd poll_msg =3D {
+		.fd =3D fd,
+		.events =3D 0x0001,
+		.revents =3D 0,
+	};
 =

 	struct iovec iov =3D {
 		.iov_base =3D (void *)nlbuf,
@@ -352,126 +360,142 @@
 		perror("Receive error");
 		return ret;
 	}
-	size_t u_msglen =3D (size_t) msglen;
-	/* Check to see if the buffers in msg get truncated */
-	if (msg.msg_namelen !=3D sizeof(peer) ||
-	    (msg.msg_flags & (MSG_TRUNC | MSG_CTRUNC))) {
-		fprintf(stderr, "Uhoh... truncated message.\n");
-		return ret;
-	}
-
-	for (nl_msg =3D (struct nlmsghdr *)nlbuf;
-	     NLMSG_OK(nl_msg, u_msglen);
-	     nl_msg =3D NLMSG_NEXT(nl_msg, u_msglen)) {
-		int type =3D nl_msg->nlmsg_type;
-		int len;
-		if (type !=3D RTM_NEWLINK)
-			continue;
-
-		struct ifinfomsg *ifi =3D NLMSG_DATA(nl_msg);
-		struct rtattr *tb[IFLA_MAX + 1];
-
-		len =3D
-		    nl_msg->nlmsg_len - NLMSG_LENGTH(sizeof(struct ifaddrmsg));
-		parse_rtattr(tb, IFLA_MAX, IFLA_RTA(ifi), len);
-
-		if (strncmp
-		    ((char *)RTA_DATA(tb[IFLA_IFNAME]), name,
-		     sizeof(name)) !=3D 0)
-			continue;
-
-		if (tb[IFLA_LINKINFO])
-			parse_rtattr_nested(linkinfo,
-					    IFLA_INFO_MAX, tb[IFLA_LINKINFO]);
-		else
-			continue;
 =

-		if (!linkinfo[IFLA_INFO_DATA]) {
-			fprintf(stderr, "no link data found\n");
+    while(repeat =3D=3D 0){
+		size_t u_msglen =3D (size_t) msglen;
+		/* Check to see if the buffers in msg get truncated */
+		if (msg.msg_namelen !=3D sizeof(peer) ||
+			(msg.msg_flags & (MSG_TRUNC | MSG_CTRUNC))) {
+			fprintf(stderr, "Uhoh... truncated message.\n");
 			return ret;
 		}
 =

-		parse_rtattr_nested(can_attr, IFLA_CAN_MAX,
-				    linkinfo[IFLA_INFO_DATA]);
-
-		switch (acquire) {
-		case GET_STATE:
-			if (can_attr[IFLA_CAN_STATE]) {
-				*((int *)res) =3D *((__u32 *)
-						  RTA_DATA(can_attr
-							   [IFLA_CAN_STATE]));
-				ret =3D 0;
-			} else {
-				fprintf(stderr, "no state data found\n");
+		for (nl_msg =3D (struct nlmsghdr *)nlbuf;
+			NLMSG_OK(nl_msg, u_msglen);
+			nl_msg =3D NLMSG_NEXT(nl_msg, u_msglen)) {
+
+			int type =3D nl_msg->nlmsg_type;
+			int len;
+			if (type !=3D RTM_NEWLINK)
+				continue;
+
+
+			struct ifinfomsg *ifi =3D NLMSG_DATA(nl_msg);
+			struct rtattr *tb[IFLA_MAX + 1];
+
+			len =3D
+				nl_msg->nlmsg_len - NLMSG_LENGTH(sizeof(struct ifaddrmsg));
+			parse_rtattr(tb, IFLA_MAX, IFLA_RTA(ifi), len);
+
+			if (strncmp
+				((char *)RTA_DATA(tb[IFLA_IFNAME]), name,
+				 sizeof(name)) !=3D 0) {
+				continue;
+			}
+			if (tb[IFLA_LINKINFO])
+				parse_rtattr_nested(linkinfo,
+							IFLA_INFO_MAX, tb[IFLA_LINKINFO]);
+			else
+				continue;
+
+			if (!linkinfo[IFLA_INFO_DATA]) {
+				fprintf(stderr, "no link data found\n");
+				return ret;
 			}
 =

-			break;
-		case GET_RESTART_MS:
-			if (can_attr[IFLA_CAN_RESTART_MS]) {
-				*((__u32 *) res) =3D *((__u32 *)
-						     RTA_DATA(can_attr
-							      [IFLA_CAN_RESTART_MS]));
-				ret =3D 0;
-			} else
-				fprintf(stderr, "no restart_ms data found\n");
-
-			break;
-		case GET_BITTIMING:
-			if (can_attr[IFLA_CAN_BITTIMING]) {
-				memcpy(res,
-				       RTA_DATA(can_attr[IFLA_CAN_BITTIMING]),
-				       sizeof(struct can_bittiming));
-				ret =3D 0;
-			} else
-				fprintf(stderr, "no bittiming data found\n");
-
-			break;
-		case GET_CTRLMODE:
-			if (can_attr[IFLA_CAN_CTRLMODE]) {
-				memcpy(res,
-				       RTA_DATA(can_attr[IFLA_CAN_CTRLMODE]),
-				       sizeof(struct can_ctrlmode));
-				ret =3D 0;
-			} else
-				fprintf(stderr, "no ctrlmode data found\n");
-
-			break;
-		case GET_CLOCK:
-			if (can_attr[IFLA_CAN_CLOCK]) {
-				memcpy(res,
-				       RTA_DATA(can_attr[IFLA_CAN_CLOCK]),
-				       sizeof(struct can_clock));
-				ret =3D 0;
-			} else
-				fprintf(stderr,
-					"no clock parameter data found\n");
+			parse_rtattr_nested(can_attr, IFLA_CAN_MAX,
+						linkinfo[IFLA_INFO_DATA]);
+
+			switch (acquire) {
+			case GET_STATE:
+				if (can_attr[IFLA_CAN_STATE]) {
+					*((int *)res) =3D *((__u32 *)
+							  RTA_DATA(can_attr
+								   [IFLA_CAN_STATE]));
+					ret =3D 0;
+				} else {
+					fprintf(stderr, "no state data found\n");
+				}
 =

-			break;
-		case GET_BITTIMING_CONST:
-			if (can_attr[IFLA_CAN_BITTIMING_CONST]) {
-				memcpy(res,
-				       RTA_DATA(can_attr[IFLA_CAN_BITTIMING_CONST]),
-				       sizeof(struct can_bittiming_const));
-				ret =3D 0;
-			} else
-				fprintf(stderr, "no bittiming_const data found\n");
-
-			break;
-		case GET_BERR_COUNTER:
-			if (can_attr[IFLA_CAN_BERR_COUNTER]) {
-				memcpy(res,
-				       RTA_DATA(can_attr[IFLA_CAN_BERR_COUNTER]),
-				       sizeof(struct can_berr_counter));
-				ret =3D 0;
-			} else
-				fprintf(stderr, "no berr_counter data found\n");
+				break;
+			case GET_RESTART_MS:
+				if (can_attr[IFLA_CAN_RESTART_MS]) {
+					*((__u32 *) res) =3D *((__u32 *)
+								 RTA_DATA(can_attr
+									  [IFLA_CAN_RESTART_MS]));
+					ret =3D 0;
+				} else
+					fprintf(stderr, "no restart_ms data found\n");
+
+				break;
+			case GET_BITTIMING:
+				if (can_attr[IFLA_CAN_BITTIMING]) {
+					memcpy(res,
+						   RTA_DATA(can_attr[IFLA_CAN_BITTIMING]),
+						   sizeof(struct can_bittiming));
+					ret =3D 0;
+				} else
+					fprintf(stderr, "no bittiming data found\n");
+
+				break;
+			case GET_CTRLMODE:
+				if (can_attr[IFLA_CAN_CTRLMODE]) {
+					memcpy(res,
+						   RTA_DATA(can_attr[IFLA_CAN_CTRLMODE]),
+						   sizeof(struct can_ctrlmode));
+					ret =3D 0;
+				} else
+					fprintf(stderr, "no ctrlmode data found\n");
+
+				break;
+			case GET_CLOCK:
+				if (can_attr[IFLA_CAN_CLOCK]) {
+					memcpy(res,
+						   RTA_DATA(can_attr[IFLA_CAN_CLOCK]),
+						   sizeof(struct can_clock));
+					ret =3D 0;
+				} else
+					fprintf(stderr,
+						"no clock parameter data found\n");
+
+				break;
+			case GET_BITTIMING_CONST:
+				if (can_attr[IFLA_CAN_BITTIMING_CONST]) {
+					memcpy(res,
+						   RTA_DATA(can_attr[IFLA_CAN_BITTIMING_CONST]),
+						   sizeof(struct can_bittiming_const));
+					ret =3D 0;
+				} else
+					fprintf(stderr, "no bittiming_const data found\n");
+
+				break;
+			case GET_BERR_COUNTER:
+				if (can_attr[IFLA_CAN_BERR_COUNTER]) {
+					memcpy(res,
+						   RTA_DATA(can_attr[IFLA_CAN_BERR_COUNTER]),
+						   sizeof(struct can_berr_counter));
+					ret =3D 0;
+				} else
+					fprintf(stderr, "no berr_counter data found\n");
 =

-			break;
+				break;
 =

-		default:
-			fprintf(stderr, "unknown acquire mode\n");
+			default:
+				fprintf(stderr, "unknown acquire mode\n");
+			}
 		}
-	}
+
+		if((poll(&poll_msg,1,1))>0) {
+			msglen =3D recvmsg(fd, &msg, 0);
+			if (msglen <=3D 0) {
+				perror("Receive error");
+				return -1;
+			}
+		}
+		else {
+			repeat =3D 1;
+		}
+	}  //while(repeat =3D=3D 0)
 	return ret;
 }

Mit freundlichen Gr=FCssen / Yours sincerely,

James Kime
Entwicklung / Development
--------------------------------------------
IXXAT Automation GmbH
Leibnizstr. 15, 88250 Weingarten, Germany
Phone +49-751-56146-181
Fax   +49-751-56146-29
mailto:kime-Z4QKGCRq86k@public.gmane.org
http://www.ixxat.de
--------------------------------------------
PRIVILEGED AND CONFIDENTIAL.
Any unauthorized use or disclosure
is strictly prohibited.
--------------------------------------------
Sitz der Gesellschaft: Weingarten
Handelsregister Ulm HRB 551905
Gesch=E4ftsf=FChrer:
Dipl.-Ing. Christian Schlegel
--------------------------------------------


-----Original Message-----
From: Wolfgang Grandegger [mailto:wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org] =

Sent: Friday, December 09, 2011 3:50 PM
To: Kime, James
Cc: socketcan-core-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org; linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: Re: CAN State Information

On 12/09/2011 02:41 PM, kime-Z4QKGCRq86k@public.gmane.org wrote:
> I noticed that when libsocketcan calls send_dump_request() it returns a m=
essage for me that has a length of 3424 with recvmsg().  This is not the fu=
ll message, if I add a loop into the routine to again receive, I receive a =
second message this time with a length of 1424.  I added some prints into t=
he routine to output strings and sizes:
> =

> First read:
> nl_msg:-1073753668  u_msglen:3424
> lo
> nl_msg:-1073752676  u_msglen:2432
> eth0
> nl_msg:-1073751668  u_msglen:1424
> can0
> nl_msg:-1073750956  u_msglen:712
> can1
> =

> Second read:
> nl_msg:-1073753668  u_msglen:1424
> can2
> nl_msg:-1073752956  u_msglen:712
> can3
> =

> With this loop, it seems to work.  Does this make sense?

Yes, could you send a patch (showing your modifications)?

Wolfgang.
