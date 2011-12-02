From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: using can-j1939
Date: Fri, 02 Dec 2011 10:05:51 +0100
Message-ID: <4ED894EF.3040006@hartkopp.net>
References: <20111201105434.214940@gmx.net> <20111201115256.GB321@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:34414 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752938Ab1LBJG0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 2 Dec 2011 04:06:26 -0500
In-Reply-To: <20111201115256.GB321@e-circ.dyndns.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Wagner <wutz@unterderbruecke.de>, Kurt Van Dijck <kurt.van.dijck@eia.be>
Cc: linux-can@vger.kernel.org

On 01.12.2011 12:52, Kurt Van Dijck wrote:

> On Thu, Dec 01, 2011 at 11:54:34AM +0100, Wolfgang Wagner wrote:
>> Hi,
>>
>> thank you very much for your fast response. Glad that you will help me.
>>
>> I want to run the can-j1939 for linux on a Phytec phycore MPC5121e with kernel release 2.6.33.5-rt2x-ptx-pcm046-3.
> I'm not that much used with specific drivers & releases. I included linux-can
> mailing list, maybe they can help to use out-of-tree CAN modules on your system.
>>
>> I managed to download the 3 thing you told me, but now I don't know to move on - I am really desperated because I can't find any proper documentation.
> Did you read Documentation/networking/can/j1939.txt from the can-j1939-modules?
> 
> The Documentation is a currently a weak point. I've had some busy months,
> and j1939 dissappeared from my priorities since our system is working
> properly.
> 
> Oliver Hartkopp has already proposed to work out some use-cases, but as said,
> I've not found time for that yet.
> Maybe this is a good opportunity to do so...


Yeah. Some things continuously pop up after some time :-)

@Wolfgang W.: We had a quite interesting and long discussion about Kurts
suggested implementation. Especially on how to deal with address claiming.
Currently the AUTOSAR J1939 specifications nearly ignore the AC which provides
the possibility of having a simple PDU interface.
But if we want to do AC the discussion comes up how much of it we put into the
kernel-space and how much we do in user-space (e.g. with an AC daemon).

I think Kurt also asked you about your planned setup. Is address claiming also
part of it?

Regards,
Oliver
