From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: getifaddrs and SocketCAN interfaces
Date: Sun, 29 Mar 2015 20:36:48 +0200
Message-ID: <55184640.8030900@hartkopp.net>
References: <CAE+ymrs_yWEgR6OVP8rCiqCr4wJtXUGkYVJNMbgZxufTROeZ4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:54287 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264AbbC2Sgz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 29 Mar 2015 14:36:55 -0400
In-Reply-To: <CAE+ymrs_yWEgR6OVP8rCiqCr4wJtXUGkYVJNMbgZxufTROeZ4Q@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Paarvai Naai <opensource3141@gmail.com>, linux-can@vger.kernel.org

On 28.03.2015 21:30, Paarvai Naai wrote:
> I recently tried using getifaddrs to list all of the SocketCAN
> interfaces on my system programmatically.
> 
> However, I found that the SocketCAN interfaces do not have their
> ifa_addr field in the returned ifaddrs structure set.  This makes it
> not possible to identifying the interface as type SocketCAN.
> Presumably if the ifa_addr field was set, we could look at the
> sa_family field and check if it is AF_CAN.

Hi Paarvai,

on the CAN bus you don't have node addresses - so there's nothing comparable
to ethernet devices which have an IP-address bound to them.

The CAN netdevice stuff in linux/driver/net/can is currently separated from
the network layer stuff in linux/net/can pretty good.

So attaching a (useless) sock_addr from the network layer to the CAN
interface seems inappropriate.

Do you know about the network device ARPHRD definitions:

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/if_arp.h#n55

> The other option is to use netlink to query the network devices, but
> that is more involved.  Is there an easier way?

E.g. you can get this netdevice type information from

$ cat /sys/class/net/vcan0/type
280

Regards,
Oliver

