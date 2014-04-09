From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: Regarding  J1939 support on freescale imx6 BSP
Date: Wed, 9 Apr 2014 21:28:11 +0200
Message-ID: <20140409192811.GB15221@vandijck-laurijssen.be>
References: <533BAD63.80202@tataelxsi.co.in>
 <20140402183759.GA4780@vandijck-laurijssen.be>
 <533CFFB7.3020300@tataelxsi.co.in>
 <20140403133934.GA449@vandijck-laurijssen.be>
 <5345572C.60602@tataelxsi.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay010.isp.belgacom.be ([195.238.6.177]:8334 "EHLO
	mailrelay010.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933354AbaDIT2i (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 9 Apr 2014 15:28:38 -0400
Content-Disposition: inline
In-Reply-To: <5345572C.60602@tataelxsi.co.in>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ratheendran <ba.rsrajeshwaran@tataelxsi.co.in>
Cc: linux-can@vger.kernel.org

Hi,

On Wed, Apr 09, 2014 at 07:50:28PM +0530, Ratheendran wrote:
> Hi Kurt Van Dijck,
> 
> Thanks for your support.
> 
> 
> I tried to implement your j1939stack on to Free-scale linux kernel
> 3.0.15,I did this by manually copying and resolving the conflicts.
> 
> Now when I test some basic command following kernel documentation.
> I am using iproute2 and can utilities compiled from your site. I get
> the following response.
> 
> 
> ./ip link set can0 j1939 on
> RTNETLINK answers: Address family not supported by protocol
> root@flex-oov:~/can# ./ip addr add dev can0 j1939 0x30
> RTNETLINK answers: Operation not supported
> root@flex-oov:~/can# ./ip addr del dev can0 j1939 0x30
> RTNETLINK answers: Operation not supported
> 

Next to the kernel, you will need j1939 support in iproute2.
Please find git@gitorious.org:linux-can/iproute2-j1939.git
You can, similar to the kernel, merge the differences,
or you can build this iproute2, and put it on the target
as ip-j1939 and call this only for j1939 related activities.
Or you can replace your iproute2 with the j1939 version,
you probably won't miss any features.

> 
> 
> Also can use the can-test(https://gitorious.org/linux-can/can-tests)
> applications for validating j1939 socket,off-course with the J1929
> related modifications.

I have not yet added such thing.
I did post in the recent past some sources together with a preliminary
kickstarter guide.


Kind regards,
Kurt

