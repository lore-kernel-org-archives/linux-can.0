From: bruce bushby <bruce.bushby@gmail.com>
Subject: Re: [Socketcan-users] AM335x CAN/D_CAN
Date: Tue, 19 Jun 2012 08:58:13 +0100
Message-ID: <CAHvj1qb0anDv8W3Jhgn5u-s+6=Kz283RJsFDonctP5qdn9fk1A@mail.gmail.com>
References: <CAHvj1qbb9YJSBLZc1bG6MpEJcjPUtr+37wn3iJUNm_OmpH2SgA@mail.gmail.com>
	<4FBBE272.5020807@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:40750 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756Ab2FSH6O (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 19 Jun 2012 03:58:14 -0400
Received: by qafi31 with SMTP id i31so2424353qaf.1
        for <linux-can@vger.kernel.org>; Tue, 19 Jun 2012 00:58:13 -0700 (PDT)
In-Reply-To: <4FBBE272.5020807@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Linux-CAN <linux-can@vger.kernel.org>

Hi Wolfgang/Oliver

Thank you for your response, much appreciated!! Clearly I've got some
reading to do :)

Regards
Bruce Bushby





On Tue, May 22, 2012 at 8:01 PM, Wolfgang Grandegger <wg@grandegger.com> wrote:
> Hello,
>
> I switched the discussion to the new Linux-CAN mailing list.
>
> On 05/22/2012 05:50 PM, bruce bushby wrote:
>> Greetings
>>
>> I'm hoping a list member would be so kind as to offer some basic
>> explanations of how one would use the CAN bus provided by AM335x. I
>> understand Linux, but struggle with electronics.
>>
>> I have read this discussion: http://comments.gmane.org/gmane.linux.can/1142
>> What is the difference between C_CAN and D_CAN?
>
> As I see it, the D_CAN is a more advanced variant of the C_CAN
> controller. See also:
>
> http://www.semiconductors.bosch.de/en/ipmodules/can/canipmodules/c_can/c_can.asp
> http://www.semiconductors.bosch.de/en/ipmodules/can/canipmodules/d_can/d_can.asp
>
> Patches to add D_CAN support to the Linux-CAN C_CAN driver have been
> posted recently for mainline inclusion and are currently reviewed.
>
>> http://www.spinics.net/lists/linux-omap/msg67538.html
>> Does D_CAN have anything to do with mcp2515?
>
> No, nothing apart from the fact that both are CAN controllers. The
> mcp2515 is connected via SPI bus and from another company.
>
>> In order to connect the am335x CAN line to a CAN bus, would I need to
>> add a CAN transceiver?
>
> Hardware-wise, yes.
>
>> Is the am335x an "in memory CAN" ... ie I wouldn't need to worry about
>> SPI bus performance?
>
> Right. On the AM335x, the D_CAN controller is integrated into the SOC.
> There is no SPI involved.
>
>> Any explanations and help much appreciated!
>
> Hope it's useful.
>
> Wolfgang.
