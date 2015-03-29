From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: getifaddrs and SocketCAN interfaces
Date: Mon, 30 Mar 2015 09:23:08 +1100
Message-ID: <55187B4C.4070706@optusnet.com.au>
References: <CAE+ymrs_yWEgR6OVP8rCiqCr4wJtXUGkYVJNMbgZxufTROeZ4Q@mail.gmail.com>
Reply-To: tom_usenet@optusnet.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:55567 "EHLO
	mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752601AbbC2WrT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 29 Mar 2015 18:47:19 -0400
In-Reply-To: <CAE+ymrs_yWEgR6OVP8rCiqCr4wJtXUGkYVJNMbgZxufTROeZ4Q@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Paarvai Naai <opensource3141@gmail.com>, linux-can@vger.kernel.org

On 29/03/15 07:30, Paarvai Naai wrote:
> Hi,
>
> I recently tried using getifaddrs to list all of the SocketCAN
> interfaces on my system programmatically.

root@triton1:/# find /sys -name "*can*"
/sys/bus/platform/devices/flexcan.0
/sys/bus/platform/devices/flexcan.1
/sys/bus/platform/drivers/flexcan
/sys/bus/platform/drivers/flexcan/flexcan.0
/sys/bus/platform/drivers/flexcan/flexcan.1
/sys/devices/soc.0/50000000.aips/flexcan.0
/sys/devices/soc.0/50000000.aips/flexcan.0/net/can0
/sys/devices/soc.0/50000000.aips/flexcan.1
/sys/devices/soc.0/50000000.aips/flexcan.1/net/can1
/sys/devices/virtual/net/vcan0
...
/sys/class/net/vcan0
/sys/class/net/can0
/sys/class/net/can1

Then I open them by name:

     struct ifreq ifr;
     strcpy(ifr.ifr_name, f_vnCanBusNames[a_eDevice]);
     /* ifr.ifr_ifindex gets filled
     rc = ioctl(pSkt->skt, SIOCGIFINDEX, &ifr);

Or was there something else you needed?

Tom

