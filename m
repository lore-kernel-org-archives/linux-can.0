From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: J1939 Interpacket Delay
Date: Wed, 9 Apr 2014 21:52:25 +0200
Message-ID: <20140409195225.GE15221@vandijck-laurijssen.be>
References: <loom.20140409T155830-71@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay006.isp.belgacom.be ([195.238.6.172]:62289 "EHLO
	mailrelay006.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933481AbaDITwf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 9 Apr 2014 15:52:35 -0400
Content-Disposition: inline
In-Reply-To: <loom.20140409T155830-71@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: swapnil <patilswa@gmail.com>
Cc: linux-can@vger.kernel.org

Hey,

part 2 ...

On Wed, Apr 09, 2014 at 02:17:11PM +0000, swapnil wrote:
> Hi All,
> 
>         Hey Kurt I am using the J1939 stack on begalbone 
> I am halfway through. I am getting some issue while testing with different 
> engine control modules
> 

[...]

> 
> 2.if There is only one device connected on the bus like Begalbone(address -
> f9) and Engine control module(address -00) 
>      if i send a message to address 01 or 02 on can bus i see message for 01 
> is converted to address 00 
> like i amsending 18EF01F9#FF000000000002FF
> but in candump i got
> (1387762810.854139) can0 18EF00F9#FA000000000002FF
> (1387762810.854762) can0 18EFF900#FB0000024733FFFF

Are you sure you send 18EF01F9?
Can you show the output of "ip addr show can0" & "ip link show can0"?
Maybe that gives me a clue.

Kind regards,
Kurt
