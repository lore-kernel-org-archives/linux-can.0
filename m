From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: SocketCAN on Intel Edison with MCP 2515
Date: Thu, 28 May 2015 18:19:40 +1000
Message-ID: <5566CF9C.4040302@optusnet.com.au>
References: <CAKa_yg_Lrpw7J70UzJf5x2EeB6mrmbFarxgbYCf+xHyD8Nb2eQ@mail.gmail.com>
Reply-To: tom_usenet@optusnet.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:35485 "EHLO
	mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751548AbbE1ITn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 May 2015 04:19:43 -0400
In-Reply-To: <CAKa_yg_Lrpw7J70UzJf5x2EeB6mrmbFarxgbYCf+xHyD8Nb2eQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Gallagher <mjg@isomorphdevelopment.com>, linux-can@vger.kernel.org

On 28/05/15 01:18, Michael Gallagher wrote:
> Hello,
>
> I am new to SocketCAN and have some basic questions, I'm hoping that
> someone might be able to point me in the right direction.
>
> I have recompiled Yocto (uname - r returns 3.10.17-yocoto standard)

That's pretty new. Newer linux versions rely more and more on the Device Tree. 
If the devices aren't enumerated in the Device Tree (meaning that you have an 
MCP2515 and it is at a specific address/chip-select on a particular SPI bus) 
then it won't enable it.

Linux used to be "Plug and Play", but they've fixed that bug...

Device Tree problems are really hard. The "language" and its "keywords" depend 
on every driver and every driver-writer, and they make different choices, and 
then change them when a new kernel comes out.

Check in the Documentation/devicetree/Bindings to see if it says what to do.

Tom

