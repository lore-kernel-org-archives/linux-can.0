From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: j1939 - first steps
Date: Mon, 18 Mar 2013 22:41:45 +0100
Message-ID: <20130318214145.GA8685@vandijck-laurijssen.be>
References: <5147756D.1060203@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay005.isp.belgacom.be ([195.238.6.171]:23041 "EHLO
	mailrelay005.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933132Ab3CRVlt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 18 Mar 2013 17:41:49 -0400
Content-Disposition: inline
In-Reply-To: <5147756D.1060203@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Mon, Mar 18, 2013 at 09:13:33PM +0100, Oliver Hartkopp wrote:
> Hi Kurt,
> 
> following the idea from Marc (cloning linux-stable, check-out 3.7.10, adding
> j1939 branch, applying the j1939-3.7 branch) i managed to get my linux-box
> working with your stack.
> 
> Following the documentation, i did this (as root):
> 
> ./ip link set vcan0 j1939 on
> ./ip addr show vcan0
> ./ip addr add dev vcan0 j1939 0x22
> ./ip addr show vcan0
> 6: vcan0: <NOARP,UP,LOWER_UP> mtu 72 qdisc noqueue state UNKNOWN
>     link/can
>     can-j1939 0x22 scope link

static addressing, ok.
> 
> And this (as user):
> 
> ./jsr -v vcan0:0x22
you should use 'vcan0:,0x22'.
The format is: 'IFACE:<NAME>[,<ADDR>]'

Better proposals to combine dynamic & static addressing in strings?
> ./jsr: bind(vcan0:0000000000000022), -99: Cannot assign requested address
indeed. The 64bit name 00...0022 is tried.

Kind regards,
Kurt
