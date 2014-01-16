From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: AW: Need support J1939 protocol support to my kernel (v3.8 on
 BeagleBone Black)
Date: Thu, 16 Jan 2014 22:43:52 +0100
Message-ID: <20140116214352.GA26545@vandijck-laurijssen.be>
References: <loom.20140115T171400-435@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay003.isp.belgacom.be ([195.238.6.53]:3575 "EHLO
	mailrelay003.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750750AbaAPVn6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 16 Jan 2014 16:43:58 -0500
Content-Disposition: inline
In-Reply-To: <loom.20140115T171400-435@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: swapnil <patilswa@gmail.com>
Cc: linux-can@vger.kernel.org

Hi Swapnil,

>        Using the test code given by you I have developed an app but I am 
> facing some issues i don't know its j1939 limitation or the stack.
> 
> 1.I want to transmit and single frame message RACM message 

RACM?
I don't know the RACM acronym. Can you explain a bit?

>    canId--18EAFEFF data 00EE00FFFFFFFFFFFF it asks to bind address with 0xFE

I guess you want 18eafffe#00ee (PGN 0ea00 is per J1939 only 3 bytes long).

Because FF is not allowed as source, and 0xfe is fuzzy to use as destination.
Likewise, 0xfe as source is common thing to do for requesting others address
claims, and FF as destination is, well, a broadcast.

> 
>    note -can i transmit single frame message like raw can from any source 
> address       
> to  any dest address.

That is true, but not every combination is a 'legal' withing J1939 context.

>     I think address claim is needed for only TP message

Address claim is needed for dynamic addressing (j1939-81).
This can be combined, but it really unrelated to TP (transport protocol).
Your story is valid without address claims also, using static addressing.

> 
> 2. In case of multiple address claims like 0x80 and 0x90 if i want to  
> transmit the data from both address parallel y do i need to create different 
> socket for each address?

s/multiple address claims/multiple addresses/

If you want to transmit both 18000080#xxxx & 18000090#xxxx, you need a different
socket for each address.

Note that a single source address indicates a logical node.
It's quite uncommon to combine different logical nodes into 1 program,
but if you'd want to, different sockets is the way to go ...

> 
> 3.It don't reply for RACM message if i send from different  adapter
>   example: 18EAFEFF#00EE00FFFFFFFFFFFF j1939 stack should reply with claimed 
> address Like 80 and 90 

I see what you mean.

18eafffe#00ee00 from a remote should be replied with the address claims.
You should really consider using jacd then.
That will deal with j1939-81 (1 instance for each SA).

Do you need dynamic addresses? Static addresses make things a lot simpler.
And static addresses allow Transport Protocol :-).

>  
>         I was busy in creating the app  to test the linux j1939 stack on 
> begalbone Black. thank you very much for the test programs those helped me 
> a lot 

That's cool! It feels fine that it helps others.

-- 
Kurt Van Dijck
