From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: loopback  problem with BCM, RAW using,   Daniele Venzano
Date: Fri, 17 Aug 2012 14:13:57 +0200 (CEST)
Message-ID: <1899121230.725766.1345205637801.JavaMail.open-xchange@webmail.strato.de>
References: <OF5F6ABAA1.C0168430-ONC1257A5D.003ADDEA-C1257A5D.003C4200@continental-corporation.com>
Reply-To: Oliver Hartkopp <socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_725765_17368216.1345205637734"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:39093 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757979Ab2HQMOD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 17 Aug 2012 08:14:03 -0400
In-Reply-To: <OF5F6ABAA1.C0168430-ONC1257A5D.003ADDEA-C1257A5D.003C4200@continental-corporation.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org, Mahesh.Maharjan-EXT@continental-corporation.com

------=_Part_725765_17368216.1345205637734
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello Mahesh,

i tried to generate a patch that allows you to disable the reception of local
generated CAN messages.

The patch is based on Kernel 3.6-rc2 - but it should be easy to backport by
hand.

Can you try it, if it solves your problem?

Maybe this extension to the CAN_RAW socket is useful for other people also ...

Regards,
Oliver

diff --git a/Documentation/networking/can.txt b/Documentation/networking/can.txt
index 820f553..b6d28bd 100644
--- a/Documentation/networking/can.txt
+++ b/Documentation/networking/can.txt
@@ -23,7 +23,8 @@ This file contains
       4.1.3 RAW socket option CAN_RAW_LOOPBACK
       4.1.4 RAW socket option CAN_RAW_RECV_OWN_MSGS
       4.1.5 RAW socket option CAN_RAW_FD_FRAMES
-      4.1.6 RAW socket returned message flags
+      4.1.6 RAW socket option CAN_RAW_RECV_HOST_MSGS
+      4.1.7 RAW socket returned message flags
     4.2 Broadcast Manager protocol sockets (SOCK_DGRAM)
     4.3 connected transport protocols (SOCK_SEQPACKET)
     4.4 unconnected transport protocols (SOCK_DGRAM)
@@ -581,7 +582,23 @@ solution for a couple of reasons:
   CAN FD frames by checking if the device maximum transfer unit is CANFD_MTU.
   The CAN device MTU can be retrieved e.g. with a SIOCGIFMTU ioctl() syscall.

-  4.1.6 RAW socket returned message flags
+  4.1.6 RAW socket option CAN_RAW_RECV_HOST_MSGS
+
+  When the local loopback is enabled, all the sent CAN frames are
+  looped back to the open CAN sockets that registered for the CAN
+  frames' CAN-ID on this given interface to meet the multi user
+  needs. The reception of the CAN frames originated from the local host
+  is therefore a wanted behaviour and enabled by default.
+
+  When the reception of locally generated CAN frames is not wanted, this
+  default behaviour may be changed on demand:
+
+    int recv_host_msgs = 0; /* 0 = disabled, 1 = enabled (default) */
+
+    setsockopt(s, SOL_CAN_RAW, CAN_RAW_RECV_HOST_MSGS,
+               &recv_host_msgs, sizeof(recv_host_msgs));
+
+  4.1.7 RAW socket returned message flags

   When using recvmsg() call, the msg->msg_flags may contain following flags:

diff --git a/include/linux/can/raw.h b/include/linux/can/raw.h
index a814062..0d53fb6 100644
--- a/include/linux/can/raw.h
+++ b/include/linux/can/raw.h
@@ -25,6 +25,7 @@ enum {
        CAN_RAW_LOOPBACK,       /* local loopback (default:on)       */
        CAN_RAW_RECV_OWN_MSGS,  /* receive my own msgs (default:off) */
        CAN_RAW_FD_FRAMES,      /* allow CAN FD frames (default:off) */
+       CAN_RAW_RECV_HOST_MSGS, /* recv local host msgs (default:on) */
 };

 #endif
diff --git a/net/can/raw.c b/net/can/raw.c
index 3e9c893..0cfbc16 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -83,6 +83,7 @@ struct raw_sock {
        int loopback;
        int recv_own_msgs;
        int fd_frames;
+       int recv_host_msgs;
        int count;                 /* number of active filters */
        struct can_filter dfilter; /* default/single filter */
        struct can_filter *filter; /* pointer to filter(s) */
@@ -120,6 +121,10 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
        if (!ro->recv_own_msgs && oskb->sk == sk)
                return;

+       /* check if we need to skip locally generated messages */
+       if (!ro->recv_host_msgs && oskb->sk)
+               return;
+
        /* do not pass frames with DLC > 8 to a legacy socket */
        if (!ro->fd_frames) {
                struct canfd_frame *cfd = (struct canfd_frame *)oskb->data;
@@ -301,6 +306,7 @@ static int raw_init(struct sock *sk)
        ro->loopback         = 1;
        ro->recv_own_msgs    = 0;
        ro->fd_frames        = 0;
+       ro->recv_host_msgs   = 1;

        /* set notifier */
        ro->notifier.notifier_call = raw_notifier;
@@ -588,6 +594,15 @@ static int raw_setsockopt(struct socket *sock, int level,
int optname,

                break;

+       case CAN_RAW_RECV_HOST_MSGS:
+               if (optlen != sizeof(ro->recv_host_msgs))
+                       return -EINVAL;
+
+               if (copy_from_user(&ro->recv_host_msgs, optval, optlen))
+                       return -EFAULT;
+
+               break;
+
        default:
                return -ENOPROTOOPT;
        }
@@ -652,6 +667,12 @@ static int raw_getsockopt(struct socket *sock, int level,
int optname,
                val = &ro->fd_frames;
                break;

+       case CAN_RAW_RECV_HOST_MSGS:
+               if (len > sizeof(int))
+                       len = sizeof(int);
+               val = &ro->recv_host_msgs;
+               break;
+
        default:
                return -ENOPROTOOPT;
        }




Mahesh.Maharjan-EXT@continental-corporation.com hat am 17. August 2012 um 12:58
geschrieben:> hello to all,
> 
> Thanks to Oliver.  Suggesting for using both RAW n' BCM together .
>
> But As Already discussed by Daniele Venzano : The loopback problems  are
> occurring , When Sending can_message from BCM , RAW also  trying to read
> all message  dynamically. ( Suppose we don't need filter in system).And  I
> want to ignore all message  coming to same my node Again.  Even I used
> same  option  for setting "loopback mode"in raw socket.  But suggestion
> mention by Daniele. : can_send(skb, 1)  from bcm.c. Sound pretty simple.
> But doesn't look better to change directly from source code. Yeah , Even I
> changed for testing .. "no work done "....
>
> Help  !!!
>
>
> With Regards,
>
> Mahesh Maharjan
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
------=_Part_725765_17368216.1345205637734
Content-Type: text/x-patch; charset=US-ASCII; name=recv_hosts_msgs.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=recv_hosts_msgs.patch

ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vbmV0d29ya2luZy9jYW4udHh0IGIvRG9jdW1lbnRh
dGlvbi9uZXR3b3JraW5nL2Nhbi50eHQKaW5kZXggODIwZjU1My4uYjZkMjhiZCAxMDA2NDQKLS0t
IGEvRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL2Nhbi50eHQKKysrIGIvRG9jdW1lbnRhdGlvbi9u
ZXR3b3JraW5nL2Nhbi50eHQKQEAgLTIzLDcgKzIzLDggQEAgVGhpcyBmaWxlIGNvbnRhaW5zCiAg
ICAgICA0LjEuMyBSQVcgc29ja2V0IG9wdGlvbiBDQU5fUkFXX0xPT1BCQUNLCiAgICAgICA0LjEu
NCBSQVcgc29ja2V0IG9wdGlvbiBDQU5fUkFXX1JFQ1ZfT1dOX01TR1MKICAgICAgIDQuMS41IFJB
VyBzb2NrZXQgb3B0aW9uIENBTl9SQVdfRkRfRlJBTUVTCi0gICAgICA0LjEuNiBSQVcgc29ja2V0
IHJldHVybmVkIG1lc3NhZ2UgZmxhZ3MKKyAgICAgIDQuMS42IFJBVyBzb2NrZXQgb3B0aW9uIENB
Tl9SQVdfUkVDVl9IT1NUX01TR1MKKyAgICAgIDQuMS43IFJBVyBzb2NrZXQgcmV0dXJuZWQgbWVz
c2FnZSBmbGFncwogICAgIDQuMiBCcm9hZGNhc3QgTWFuYWdlciBwcm90b2NvbCBzb2NrZXRzIChT
T0NLX0RHUkFNKQogICAgIDQuMyBjb25uZWN0ZWQgdHJhbnNwb3J0IHByb3RvY29scyAoU09DS19T
RVFQQUNLRVQpCiAgICAgNC40IHVuY29ubmVjdGVkIHRyYW5zcG9ydCBwcm90b2NvbHMgKFNPQ0tf
REdSQU0pCkBAIC01ODEsNyArNTgyLDIzIEBAIHNvbHV0aW9uIGZvciBhIGNvdXBsZSBvZiByZWFz
b25zOgogICBDQU4gRkQgZnJhbWVzIGJ5IGNoZWNraW5nIGlmIHRoZSBkZXZpY2UgbWF4aW11bSB0
cmFuc2ZlciB1bml0IGlzIENBTkZEX01UVS4KICAgVGhlIENBTiBkZXZpY2UgTVRVIGNhbiBiZSBy
ZXRyaWV2ZWQgZS5nLiB3aXRoIGEgU0lPQ0dJRk1UVSBpb2N0bCgpIHN5c2NhbGwuCiAKLSAgNC4x
LjYgUkFXIHNvY2tldCByZXR1cm5lZCBtZXNzYWdlIGZsYWdzCisgIDQuMS42IFJBVyBzb2NrZXQg
b3B0aW9uIENBTl9SQVdfUkVDVl9IT1NUX01TR1MKKworICBXaGVuIHRoZSBsb2NhbCBsb29wYmFj
ayBpcyBlbmFibGVkLCBhbGwgdGhlIHNlbnQgQ0FOIGZyYW1lcyBhcmUKKyAgbG9vcGVkIGJhY2sg
dG8gdGhlIG9wZW4gQ0FOIHNvY2tldHMgdGhhdCByZWdpc3RlcmVkIGZvciB0aGUgQ0FOCisgIGZy
YW1lcycgQ0FOLUlEIG9uIHRoaXMgZ2l2ZW4gaW50ZXJmYWNlIHRvIG1lZXQgdGhlIG11bHRpIHVz
ZXIKKyAgbmVlZHMuIFRoZSByZWNlcHRpb24gb2YgdGhlIENBTiBmcmFtZXMgb3JpZ2luYXRlZCBm
cm9tIHRoZSBsb2NhbCBob3N0CisgIGlzIHRoZXJlZm9yZSBhIHdhbnRlZCBiZWhhdmlvdXIgYW5k
IGVuYWJsZWQgYnkgZGVmYXVsdC4KKworICBXaGVuIHRoZSByZWNlcHRpb24gb2YgbG9jYWxseSBn
ZW5lcmF0ZWQgQ0FOIGZyYW1lcyBpcyBub3Qgd2FudGVkLCB0aGlzCisgIGRlZmF1bHQgYmVoYXZp
b3VyIG1heSBiZSBjaGFuZ2VkIG9uIGRlbWFuZDoKKworICAgIGludCByZWN2X2hvc3RfbXNncyA9
IDA7IC8qIDAgPSBkaXNhYmxlZCwgMSA9IGVuYWJsZWQgKGRlZmF1bHQpICovCisKKyAgICBzZXRz
b2Nrb3B0KHMsIFNPTF9DQU5fUkFXLCBDQU5fUkFXX1JFQ1ZfSE9TVF9NU0dTLAorICAgICAgICAg
ICAgICAgJnJlY3ZfaG9zdF9tc2dzLCBzaXplb2YocmVjdl9ob3N0X21zZ3MpKTsKKworICA0LjEu
NyBSQVcgc29ja2V0IHJldHVybmVkIG1lc3NhZ2UgZmxhZ3MKIAogICBXaGVuIHVzaW5nIHJlY3Zt
c2coKSBjYWxsLCB0aGUgbXNnLT5tc2dfZmxhZ3MgbWF5IGNvbnRhaW4gZm9sbG93aW5nIGZsYWdz
OgogCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2Nhbi9yYXcuaCBiL2luY2x1ZGUvbGludXgv
Y2FuL3Jhdy5oCmluZGV4IGE4MTQwNjIuLjBkNTNmYjYgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGlu
dXgvY2FuL3Jhdy5oCisrKyBiL2luY2x1ZGUvbGludXgvY2FuL3Jhdy5oCkBAIC0yNSw2ICsyNSw3
IEBAIGVudW0gewogCUNBTl9SQVdfTE9PUEJBQ0ssCS8qIGxvY2FsIGxvb3BiYWNrIChkZWZhdWx0
Om9uKSAgICAgICAqLwogCUNBTl9SQVdfUkVDVl9PV05fTVNHUywJLyogcmVjZWl2ZSBteSBvd24g
bXNncyAoZGVmYXVsdDpvZmYpICovCiAJQ0FOX1JBV19GRF9GUkFNRVMsCS8qIGFsbG93IENBTiBG
RCBmcmFtZXMgKGRlZmF1bHQ6b2ZmKSAqLworCUNBTl9SQVdfUkVDVl9IT1NUX01TR1MsCS8qIHJl
Y3YgbG9jYWwgaG9zdCBtc2dzIChkZWZhdWx0Om9uKSAqLwogfTsKIAogI2VuZGlmCmRpZmYgLS1n
aXQgYS9uZXQvY2FuL3Jhdy5jIGIvbmV0L2Nhbi9yYXcuYwppbmRleCAzZTljODkzLi4wY2ZiYzE2
IDEwMDY0NAotLS0gYS9uZXQvY2FuL3Jhdy5jCisrKyBiL25ldC9jYW4vcmF3LmMKQEAgLTgzLDYg
KzgzLDcgQEAgc3RydWN0IHJhd19zb2NrIHsKIAlpbnQgbG9vcGJhY2s7CiAJaW50IHJlY3Zfb3du
X21zZ3M7CiAJaW50IGZkX2ZyYW1lczsKKwlpbnQgcmVjdl9ob3N0X21zZ3M7CiAJaW50IGNvdW50
OyAgICAgICAgICAgICAgICAgLyogbnVtYmVyIG9mIGFjdGl2ZSBmaWx0ZXJzICovCiAJc3RydWN0
IGNhbl9maWx0ZXIgZGZpbHRlcjsgLyogZGVmYXVsdC9zaW5nbGUgZmlsdGVyICovCiAJc3RydWN0
IGNhbl9maWx0ZXIgKmZpbHRlcjsgLyogcG9pbnRlciB0byBmaWx0ZXIocykgKi8KQEAgLTEyMCw2
ICsxMjEsMTAgQEAgc3RhdGljIHZvaWQgcmF3X3JjdihzdHJ1Y3Qgc2tfYnVmZiAqb3NrYiwgdm9p
ZCAqZGF0YSkKIAlpZiAoIXJvLT5yZWN2X293bl9tc2dzICYmIG9za2ItPnNrID09IHNrKQogCQly
ZXR1cm47CiAKKwkvKiBjaGVjayBpZiB3ZSBuZWVkIHRvIHNraXAgbG9jYWxseSBnZW5lcmF0ZWQg
bWVzc2FnZXMgKi8KKwlpZiAoIXJvLT5yZWN2X2hvc3RfbXNncyAmJiBvc2tiLT5zaykKKwkJcmV0
dXJuOworCiAJLyogZG8gbm90IHBhc3MgZnJhbWVzIHdpdGggRExDID4gOCB0byBhIGxlZ2FjeSBz
b2NrZXQgKi8KIAlpZiAoIXJvLT5mZF9mcmFtZXMpIHsKIAkJc3RydWN0IGNhbmZkX2ZyYW1lICpj
ZmQgPSAoc3RydWN0IGNhbmZkX2ZyYW1lICopb3NrYi0+ZGF0YTsKQEAgLTMwMSw2ICszMDYsNyBA
QCBzdGF0aWMgaW50IHJhd19pbml0KHN0cnVjdCBzb2NrICpzaykKIAlyby0+bG9vcGJhY2sgICAg
ICAgICA9IDE7CiAJcm8tPnJlY3Zfb3duX21zZ3MgICAgPSAwOwogCXJvLT5mZF9mcmFtZXMgICAg
ICAgID0gMDsKKwlyby0+cmVjdl9ob3N0X21zZ3MgICA9IDE7CiAKIAkvKiBzZXQgbm90aWZpZXIg
Ki8KIAlyby0+bm90aWZpZXIubm90aWZpZXJfY2FsbCA9IHJhd19ub3RpZmllcjsKQEAgLTU4OCw2
ICs1OTQsMTUgQEAgc3RhdGljIGludCByYXdfc2V0c29ja29wdChzdHJ1Y3Qgc29ja2V0ICpzb2Nr
LCBpbnQgbGV2ZWwsIGludCBvcHRuYW1lLAogCiAJCWJyZWFrOwogCisJY2FzZSBDQU5fUkFXX1JF
Q1ZfSE9TVF9NU0dTOgorCQlpZiAob3B0bGVuICE9IHNpemVvZihyby0+cmVjdl9ob3N0X21zZ3Mp
KQorCQkJcmV0dXJuIC1FSU5WQUw7CisKKwkJaWYgKGNvcHlfZnJvbV91c2VyKCZyby0+cmVjdl9o
b3N0X21zZ3MsIG9wdHZhbCwgb3B0bGVuKSkKKwkJCXJldHVybiAtRUZBVUxUOworCisJCWJyZWFr
OworCiAJZGVmYXVsdDoKIAkJcmV0dXJuIC1FTk9QUk9UT09QVDsKIAl9CkBAIC02NTIsNiArNjY3
LDEyIEBAIHN0YXRpYyBpbnQgcmF3X2dldHNvY2tvcHQoc3RydWN0IHNvY2tldCAqc29jaywgaW50
IGxldmVsLCBpbnQgb3B0bmFtZSwKIAkJdmFsID0gJnJvLT5mZF9mcmFtZXM7CiAJCWJyZWFrOwog
CisJY2FzZSBDQU5fUkFXX1JFQ1ZfSE9TVF9NU0dTOgorCQlpZiAobGVuID4gc2l6ZW9mKGludCkp
CisJCQlsZW4gPSBzaXplb2YoaW50KTsKKwkJdmFsID0gJnJvLT5yZWN2X2hvc3RfbXNnczsKKwkJ
YnJlYWs7CisKIAlkZWZhdWx0OgogCQlyZXR1cm4gLUVOT1BST1RPT1BUOwogCX0K
------=_Part_725765_17368216.1345205637734--
