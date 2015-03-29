From: dev.kurt@vandijck-laurijssen.be
Subject: Re: getifaddrs and SocketCAN interfaces
Date: Sun, 29 Mar 2015 21:40:23 +0200
Message-ID: <2923D548-AE6E-4B5F-A5DD-A8F8E6570890@vandijck-laurijssen.be>
References: <CAE+ymrs_yWEgR6OVP8rCiqCr4wJtXUGkYVJNMbgZxufTROeZ4Q@mail.gmail.com> <55184640.8030900@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relaygateway02.edpnet.net ([212.71.1.211]:60683 "EHLO
	relaygateway02.edpnet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418AbbC2Tka (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 29 Mar 2015 15:40:30 -0400
In-Reply-To: <55184640.8030900@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Paarvai Naai <opensource3141@gmail.com>, linux-can@vger.kernel.org



On 29 March 2015 20:36:48 CEST, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>On 28.03.2015 21:30, Paarvai Naai wrote:
>> I recently tried using getifaddrs to list all of the SocketCAN
>> interfaces on my system programmatically.
>> 
>> However, I found that the SocketCAN interfaces do not have their
>> ifa_addr field in the returned ifaddrs structure set.  This makes it
>> not possible to identifying the interface as type SocketCAN.
>> Presumably if the ifa_addr field was set, we could look at the
>> sa_family field and check if it is AF_CAN.
>
>Hi Paarvai,
>
>on the CAN bus you don't have node addresses - so there's nothing
>comparable
>to ethernet devices which have an IP-address bound to them.
>
>The CAN netdevice stuff in linux/driver/net/can is currently separated
>from
>the network layer stuff in linux/net/can pretty good.
>
>So attaching a (useless) sock_addr from the network layer to the CAN
>interface seems inappropriate.
>
>Do you know about the network device ARPHRD definitions:
>
>http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/if_arp.h#n55
>
>> The other option is to use netlink to query the network devices, but
>> that is more involved.  Is there an easier way?
>
>E.g. you can get this netdevice type information from

I created
https://github.com/kurt-vd/enumif
for this reason.
I'd explain if I was using my own computer

Kurt
