From: Martin Kozusky <mkozusky@kkmicro.cz>
Subject: Re: Flexcan - timestamp from message buffer to userspace
Date: Tue, 22 Oct 2013 14:22:34 +0200
Message-ID: <52666E0A.6000100@kkmicro.cz>
References: <l3r0ki$hde$1@ger.gmane.org> <526113A1.8020403@kkmicro.cz> <526148E9.4040406@hartkopp.net> <5264CFA6.9050805@kkmicro.cz> <07b96b822a3778b2279d78b90cda3908@grandegger.com> <9d0a209e86731f7a68f84dbdc52124cc@grandegger.com> <5264EBB9.3010803@kkmicro.cz> <5264F918.1050408@kkmicro.cz> <df0fb8a7e99577852c73a96a605465c5@grandegger.com> <52655660.30100@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:39672 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752196Ab3JVMWu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 22 Oct 2013 08:22:50 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1VYaz2-0007HE-Sg
	for linux-can@vger.kernel.org; Tue, 22 Oct 2013 14:22:48 +0200
Received: from 213.191.105.242 ([213.191.105.242])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 22 Oct 2013 14:22:48 +0200
Received: from mkozusky by 213.191.105.242 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 22 Oct 2013 14:22:48 +0200
In-Reply-To: <52655660.30100@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: socketcan@hartkopp.net

Dne 21.10.2013 18:29, Oliver Hartkopp napsal(a):
> On 21.10.2013 13:23, Wolfgang Grandegger wrote:
>> On Mon, 21 Oct 2013 11:51:20 +0200, Martin Kozusky <mkozusky@kkmicro=
=2Ecz>
>
>
>>
>>> When I do
>>
>>>    ioctl(sock, SIOCSHWTSTAMP, &hwtstamp) it returns ENOTSUP :( do I=
 have
>>
>>> to define this ioctl somehow in the flexcan driver or somewhere els=
e?
>>
>>
>>
>> Yes, it looks like. Doing an "identifier search" for SIOCSHWTSTAMP i=
n
>>
>> "http://lxr.free-electrons.com/source/" should list various drivers
>>
>> implementing that request.
>>
>
> Hi Martin,
>
> if you want to configure the selection of available timestamps, there=
 needs
> to be implemented something in the driver itself.
>
> E.g. if a network driver supports filtering for special packet types =
to send
> the timestamps only for these packets, it need to present it's capabi=
lities
> and also needs to implement the existing configuration API.
>
> E.g. if you say:
> # ethtool -T can0
> Time stamping parameters for can0:
> Capabilities:
> 	software-receive      (SOF_TIMESTAMPING_RX_SOFTWARE)
> 	software-system-clock (SOF_TIMESTAMPING_SOFTWARE)
> PTP Hardware Clock: none
> Hardware Transmit Timestamp Modes: none
> Hardware Receive Filter Modes: none
>
> This is the output from my SJA1000 based EMS PCMCIA card.
> But for the software device vcan0 it's the same.
>
>  From what i get from this interface is only software timestamps.
>
> I played with candump yesterday:
>
> diff --git a/candump.c b/candump.c
> index c865bd7..44a59b2 100644
> --- a/candump.c
> +++ b/candump.c
> @@ -60,6 +60,7 @@
>
>   #include <linux/can.h>
>   #include <linux/can/raw.h>
> +#include <linux/net_tstamp.h>
>
>   #include "terminal.h"
>   #include "lib.h"
> @@ -537,6 +538,7 @@ int main(int argc, char **argv)
>
>   		if (timestamp || log || logfrmt) {
>
> +#if 1
>   			const int timestamp_on =3D 1;
>
>   			if (setsockopt(s[i], SOL_SOCKET, SO_TIMESTAMP,
> @@ -544,6 +546,17 @@ int main(int argc, char **argv)
>   				perror("setsockopt SO_TIMESTAMP");
>   				return 1;
>   			}
> +#endif
> +#if 1
> +//			const int timestamping_flags =3D ( SOF_TIMESTAMPING_RX_SOFTWARE=
 |  SOF_TIMESTAMPING_RX_HARDWARE |  SOF_TIMESTAMPING_SOFTWARE);
> +			const int timestamping_flags =3D ( SOF_TIMESTAMPING_RX_SOFTWARE |=
  SOF_TIMESTAMPING_SOFTWARE);
> +
> +			if (setsockopt(s[i], SOL_SOCKET, SO_TIMESTAMPING,
> +				       &timestamping_flags, sizeof(timestamping_flags)) < 0) {
> +				perror("setsockopt SO_TIMESTAMPING");
> +				return 1;
> +			}
> +#endif
>   		}
>
>   		if (dropmonitor) {
> @@ -664,10 +677,36 @@ int main(int argc, char **argv)
>   				for (cmsg =3D CMSG_FIRSTHDR(&msg);
>   				     cmsg && (cmsg->cmsg_level =3D=3D SOL_SOCKET);
>   				     cmsg =3D CMSG_NXTHDR(&msg,cmsg)) {
> -					if (cmsg->cmsg_type =3D=3D SO_TIMESTAMP)
> +					if (cmsg->cmsg_type =3D=3D SO_TIMESTAMP) {
> +						printf("SO_TIMESTAMP\n");
>   						tv =3D *(struct timeval *)CMSG_DATA(cmsg);
> -					else if (cmsg->cmsg_type =3D=3D SO_RXQ_OVFL)
> +					} else if (cmsg->cmsg_type =3D=3D SO_TIMESTAMPNS) {
> +						printf("SO_TIMESTAMPNS\n");
> +						tv =3D *(struct timeval *)CMSG_DATA(cmsg);
> +					} else if (cmsg->cmsg_type =3D=3D SO_TIMESTAMPING) {
> +
> +						struct timespec *stamp =3D (struct timespec *)CMSG_DATA(cmsg);
> +
> +						printf("SO_TIMESTAMPING\n");
> +						tv =3D *(struct timeval *)CMSG_DATA(cmsg);
> +
> +						printf("SW %lu.%09lu ",
> +						       (long)stamp->tv_sec,
> +						       (long)stamp->tv_nsec);
> +						stamp++;
> +						printf("HW transformed %lu.%09lu ",
> +						       (long)stamp->tv_sec,
> +						       (long)stamp->tv_nsec);
> +						stamp++;
> +						printf("HW raw %lu.%09lu",
> +						       (long)stamp->tv_sec,
> +						       (long)stamp->tv_nsec);
> +						printf("\n");
> +
> +					} else if (cmsg->cmsg_type =3D=3D SO_RXQ_OVFL) {
> +						printf("SO_RXQ_OVFL\n");
>   						dropcnt[i] =3D *(__u32 *)CMSG_DATA(cmsg);
> +					} else printf("cmsg->cmsg_type =3D %d\n", cmsg->cmsg_type);
>   				}
>
>   				/* check for (unlikely) dropped frames on this specific socket =
*/
>
>
>
>
>
> The problem is, when i set both SO_TIMESTAMP AND SO_TIMESTAMPING i ge=
t trash
> in the SO_TIMESTAMPING values.
>
> When I set either SO_TIMESTAMP OR SO_TIMESTAMPING i can see a good an=
d valid
> software timestamp. (compared with an unmodified candump).
>
> Any idea about that?

Hello Oliver,
today I was searching kernel sources for the place where SO_TIMESTAMPIN=
G msg is filled with data from skb_shared_hwtstamps.
I found a place in net/socket.c - function __sock_recv_timestamp
I found that I just need to use those flags:

const  int so_timestamping_flags =3D SOF_TIMESTAMPING_SOFTWARE|SOF_TIME=
STAMPING_RAW_HARDWARE|SOF_TIMESTAMPING_SYS_HARDWARE

to have all 3 items of scm_timestamping struct filled.

So I enabled it with setsockopt SO_TIMESTAMPING ...
And also was getting strange results when I got SO_TIMESTAMP enabled.

Then I was going through kernel sources to the closest level to user an=
d debuged data from msg. Timestamps were always correct in kernel, but =
not in program.
Then I noticed, that I have ctrmsg used in recvmsg
msg.msg_control =3D &ctrlmsg
msg.msg_controllen =3D sizeof(ctrlmsg);

defined as
char ctrlmsg[CMSG_SPACE(sizeof(struct timeval)) + CMSG_SPACE(sizeof(__u=
32))];
(yes, copied from candump when I was starting :)

I tried to use definition from
http://lxr.free-electrons.com/source/Documentation/networking/timestamp=
ing/timestamping.c

struct {
     struct cmsghdr cm;
     char control[512];
} ctrlmsg;

and wow,  it's working now :)
I have all 3 timestamps available and correct. And I can also use SO_TI=
MESTAMPING and SO_TIMESTAMP together

I also added support for the call of ioctl/SIOCSHWTSTAMP to the flexcan=
 driver (although it does nothing and later I removed this call from th=
e program and just use setsockopt/SO_TIMESTAMPING)

this is my patch for flexcan.c, I could also add support for hwtstamp t=
o error frames, but I don't need that now.


--- flexcan.c_old_2013_10_21        2013-10-21 14:01:56.000000000 +0200
+++ flexcan.c   2013-10-22 14:17:53.000000000 +0200
@@ -459,6 +459,8 @@
         return 1;
  }

+u16 rx_time;
+
  static void flexcan_read_fifo(const struct net_device *dev,
                               struct can_frame *cf)
  {
@@ -481,7 +483,7 @@

         *(__be32 *)(cf->data + 0) =3D cpu_to_be32(readl(&mb->data[0]))=
;
         *(__be32 *)(cf->data + 4) =3D cpu_to_be32(readl(&mb->data[1]))=
;
-
+        rx_time =3D FLEXCAN_MB_CNT_TIMESTAMP(reg_ctrl);
         /* mark as read */
         writel(FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->iflag1);
         readl(&regs->timer);
@@ -492,6 +494,7 @@
         struct net_device_stats *stats =3D &dev->stats;
         struct can_frame *cf;
         struct sk_buff *skb;
+        struct skb_shared_hwtstamps *hwts;

         skb =3D alloc_can_skb(dev, &cf);
         if (unlikely(!skb)) {
@@ -499,9 +502,15 @@
                 return 0;
         }

+       skb->tstamp=3Dktime_get_real(); //get most accurate time, don't=
 wait for netif_receive_skb assignment
+        hwts =3D skb_hwtstamps(skb);
+        memset(hwts, 0, sizeof(*hwts));
         flexcan_read_fifo(dev, cf);
+        hwts->hwtstamp =3D ns_to_ktime(rx_time);
+        hwts->syststamp =3D skb->tstamp;
         netif_receive_skb(skb);

+       //dev_info(dev->dev.parent, "hwtstamp =3D %06d\n", rx_time); //=
timestamp from registers is OK here
         stats->rx_packets++;
         stats->rx_bytes +=3D cf->can_dlc;

@@ -847,11 +856,26 @@
         return 0;
  }

+static int flexcan_ioctl(struct net_device *dev, struct ifreq *ifr, in=
t cmd)
+{
+ switch (cmd)
+ {
+  case SIOCSHWTSTAMP:
+   return 0;
+  break;
+  default:
+   return -EOPNOTSUPP;
+  break;
+ }
+
+ return EINVAL;
+}

  static const struct net_device_ops flexcan_netdev_ops =3D {
         .ndo_open       =3D flexcan_open,
         .ndo_stop       =3D flexcan_close,
         .ndo_start_xmit =3D flexcan_start_xmit,
+       .ndo_do_ioctl     =3D flexcan_ioctl
  };

  static int __devinit register_flexcandev(struct net_device *dev)


Martin



> Best regards,
> Oliver
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


---
Tato zpr=C3=A1va neobsahuje viry ani jin=C3=BD =C5=A1kodliv=C3=BD k=C3=B3=
d - avast! Antivirus je aktivn=C3=AD.
http://www.avast.com


