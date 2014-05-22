From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: Kernel Oops when setting j1939 device on
Date: Thu, 22 May 2014 11:29:27 +0200
Message-ID: <20140522092927.GA23173@vandijck-laurijssen.be>
References: <CAJdBzeATNb2pBOdp5bpx86Bw+K00wYwjgFOuRGbtZSPXvMoBuQ@mail.gmail.com>
 <20140520201654.GD25701@vandijck-laurijssen.be>
 <CAJdBzeBEL=pz4imZvywVwZsjj3o7Gh6JshgKrm3aSbYOjMiZ6Q@mail.gmail.com>
 <20140521191215.GA581@vandijck-laurijssen.be>
 <CAJdBzeA8=UVGa0yR2AUexEJjhtcd16P=iwdoM8+MqM=UHvfdCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay004.isp.belgacom.be ([195.238.6.170]:8146 "EHLO
	mailrelay004.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752805AbaEVJ3Z (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 May 2014 05:29:25 -0400
Content-Disposition: inline
In-Reply-To: <CAJdBzeA8=UVGa0yR2AUexEJjhtcd16P=iwdoM8+MqM=UHvfdCw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Timothy Vieregge <tvieregge@clearpathrobotics.com>
Cc: linux-can@vger.kernel.org

On Wed, May 21, 2014 at 05:01:44PM -0400, Timothy Vieregge wrote:
> On Wed, May 21, 2014 at 3:12 PM, Kurt Van Dijck
> <dev.kurt@vandijck-laurijssen.be> wrote:
> > Hey Timothy,
> >
> > On Tue, May 20, 2014 at 04:46:10PM -0400, Timothy Vieregge wrote:
[...]
> >>
> >> I didn't specifically replace any of the modules, I simply loaded the
> >> ones that were present in the custom kernel (can, vcan and can_raw).
> >
> > 1. did you "insmod xxx" or "modprobe xxx"
> > 2. Didn't you load can-j1939?
> 
> I used modprobe.
> 
> I did not. Unsurprisingly that fixed my problems.
> I'll update the elinux wiki slightly once I have access. That should
> avoid some of
> the questions like this in the future.

That is a fine idea.
Anyway, 'ip link set vcan0 j1939 on' should return with something
like 'protocol not supported', as does my system, until you manually
load can-j1939.

loading can-j1939 automatically did not work due to the netlink locks.

Kind regards,
Kurt
