From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: Troubleshooting bus errors, bus turns off during canplayer
 playback
Date: Fri, 23 Dec 2016 23:03:07 +1100
Message-ID: <7497ef25-5968-f707-0dcc-d7fdb4a972d2@optusnet.com.au>
References: <CAFoRp-PSPtdenVSihp+Ar-1xfsOQd1M6rrUN6kgMOGd2egCcoA@mail.gmail.com>
 <7f223f19-7e27-50f4-85c2-3c6785deae91@optusnet.com.au>
 <CAFoRp-P4Arepyya2PyzLVzNLdn60FR1dzVzUCSQx5CJTxLt=qQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:36881 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932873AbcLWMDQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 23 Dec 2016 07:03:16 -0500
In-Reply-To: <CAFoRp-P4Arepyya2PyzLVzNLdn60FR1dzVzUCSQx5CJTxLt=qQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Hans L <thehans@gmail.com>, linux-can@vger.kernel.org

On 22/12/2016 5:08 AM, Hans L wrote:
 > I'm reading some of these links talking about the issue of dealing
 > with multiple programs accessing the socket, but in the case I'm
 > dealing with, there's only one program connecting to the can socket on
 > this device.

That's not the problem. The network layer is set up to assume 1500-byte 
Ethernet packets. There are two limits - the number of packets on the 
lower just-above-the-hardware queue and the number of buffers taken up 
by each socket. The default settings mean that programs sending "as fast 
as they can" like an FTP file-transfer will block before the hit the 
"start dumping buffers" limit. By default, CAN is set up completely the 
wrong way for this. You have to increase the hardware queue (who ever 
thought "10" was a good number?) and change the socket limit.

 > That program is canplayer.  So I would need to patch
 > canplayer with that setsockopt code you are suggesting?

If it doesn't have a command to make it rate-limit its transmissions - 
if it is written assuming the lower layers will properly flow-control 
it, then I'd say "yes". There may be a way to change the OS defaults so 
you don't have to patch it. It may make it a better program if you do 
add explicit command-line-specified rate-limiting to it.

Tom


