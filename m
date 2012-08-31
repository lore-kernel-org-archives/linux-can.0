From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Full Buffers and the Passive bus
Date: Fri, 31 Aug 2012 19:32:42 +0200
Message-ID: <5040F53A.5080609@hartkopp.net>
References: <CACJ51z3wGmSnZ3U-qe_QLSPnNuRb54k5=5zuQ+DBQ0aFohcvVw@mail.gmail.com> <5040EAFE.9000500@hartkopp.net> <CACJ51z35dnc7udK2AaYxRrf6vgZLvC=V-Weuf8TokTL0=3nAbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:22397 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754224Ab2HaRcp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 31 Aug 2012 13:32:45 -0400
In-Reply-To: <CACJ51z35dnc7udK2AaYxRrf6vgZLvC=V-Weuf8TokTL0=3nAbA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andrew Bell <andrew.bell.ia@gmail.com>
Cc: linux-can@vger.kernel.org

On 31.08.2012 18:52, Andrew Bell wrote:

> On Fri, Aug 31, 2012 at 11:49 AM, Oliver Hartkopp
> <socketcan@hartkopp.net> wrote:
>> On 31.08.2012 18:36, Andrew Bell wrote:
>>
>>> Is there some way within socket CAN to detect the state when no nodes
>>> are on the BUS?  I do get CAN_ERR_TX_TIMEOUT error frames after some
>>> time, but I'm writing to the BUS faster than frames drain from the
>>> buffers, so eventually buffers fill up and writes start failing.  In
>>> this case, write does return ENOBUFS.  But I'd like to be able to
>>> differentiate between the case where buffers are full because of some
>>> transient condition (I'm writing too fast for the BUS) and the
>>> condition when nobody is home to receive anything at all.
>>>
>>> Suggestions appreciated.
>>
>>
>> Hello Andrew,
>>
>> this first idea was to check, if the successful transmissions increase the tx
>> counter in the netdevice statistics. When there's no increasing value no
>> frames have been sent on the wire.
> 
> Thanks for the idea.
> 
> What is the interface/API for getting these statistics?
> 


/sbin/ifconfig reads /proc/net/dev for this reason.

But strace /sbin/ifstat turns out, that ifstat uses AF_NETLINK sockets.

(..)
socket(PF_NETLINK, SOCK_RAW, 0)         = 4
setsockopt(4, SOL_SOCKET, SO_SNDBUF, [32768], 4) = 0
setsockopt(4, SOL_SOCKET, SO_RCVBUF, [1048576], 4) = 0
bind(4, {sa_family=AF_NETLINK, pid=0, groups=00000000}, 12) = 0
getsockname(4, {sa_family=AF_NETLINK, pid=5009, groups=00000000}, [12]) = 0
time(NULL)                              = 1346434087
send(4, "\34\0\0\0\22\0\1\3(\364@P\0\0\0\0\2\0\0\0\10\0\35\0\1\0\0\0", 28, 0) = 28
recvmsg(4, {msg_name(12)={sa_family=AF_NETLINK, pid=0, groups=00000000}, msg_iov(1)=[{"\374\3\0\0\20\0\2\0(\364@P\221\23\0\0\0\0\4\3\1\0\0\0I\0\1\0\0\0\0\0"..., 16384}], msg_controllen=0, msg_flags=0}, 0) = 3652
recvmsg(4, {msg_name(12)={sa_family=AF_NETLINK, pid=0, groups=00000000}, msg_iov(1)=[{"8\2\0\0\20\0\2\0(\364@P\221\23\0\0\0\0\30\1\5\0\0\0\301\0\1\0\0\0\0\0"..., 16384}], msg_controllen=0, msg_flags=0}, 0) = 1704
recvmsg(4, {msg_name(12)={sa_family=AF_NETLINK, pid=0, groups=00000000}, msg_iov(1)=[{"\24\0\0\0\3\0\2\0(\364@P\221\23\0\0\0\0\0\0\5\0\0\0\301\0\1\0\0\0\0\0"..., 16384}], msg_controllen=0, msg_flags=0}, 0) = 20
close(4)                                = 0
(..)

I would try the AF_NETLINK method, but i have no sample code at hand.

Please check out for the ifstat code yourself.

Regards,
Oliver
