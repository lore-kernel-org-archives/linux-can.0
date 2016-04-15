From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Bad reading from mcp2515 with j1939
Date: Fri, 15 Apr 2016 16:52:55 +0200
Message-ID: <57110047.3040305@grandegger.com>
References: <136B5347-DD98-4021-98C5-2FD18FC925A4@anemomind.com>
 <20160415101957.GA22129@airbook.vandijck-laurijssen.be>
 <4C069C3C-A7B8-4D3D-BA66-0D2140E93996@anemomind.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy02.manitu.net ([217.11.48.150]:50381 "EHLO
	mailproxy02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108AbcDOOxA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 15 Apr 2016 10:53:00 -0400
In-Reply-To: <4C069C3C-A7B8-4D3D-BA66-0D2140E93996@anemomind.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Julien Pilet <julien@anemomind.com>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello,

Am 15.04.2016 um 15:02 schrieb Julien Pilet:
> Hi,
>
> Thanks for your response.
>
> I managed to reproduce the error and validate that the reading is err=
oneous.
>
> I have one device sending can messages. I have two device reading, on=
e being my mcp2515, the other is a usb nmea2000 adapter from actisense.
>
> Beside the changing sequence id (first byte) I expect to read always =
the same data. So I ran:
>
> ./candump can0  | grep 09FD0200 | grep -v "19 00 60 7A FA FF FF"
>
> It selects only the messages I=E2=80=99m interested in (09FD0200) and=
 remove correct frames. Most frames are correct and are not displayed. =
A few frames show wrong values, though:
>    can0  09FD0200   [8]  AA 99 00 60 7A FA FF FF
>    can0  09FD0200   [8]  C2 99 00 60 7A FA FF FF
>    can0  09FD0200   [8]  AA 99 00 60 7A FA FF FF
>    can0  09FD0200   [8]  AE 99 00 60 7A FA FF FF
>    can0  09FD0200   [8]  A6 99 00 60 7A FA FF FF
>    can0  09FD0200   [8]  86 99 00 60 7A FA FF FF
>    can0  09FD0200   [8]  E6 99 00 60 7A FA FF FF
>    can0  09FD0200   [8]  8E 99 00 60 7A FA FF FF
>    can0  09FD0200   [8]  8E 99 00 60 7A FA FF FF
>    can0  09FD0200   [8]  A2 99 00 60 7A FA FF FF
>    can0  09FD0200   [8]  CA 99 00 60 7A FA FF FF
>
> It is again the MSB bit of byte number 2 which is wrong. It should sh=
ow 19 00, not 99 00. On the other reading device, I see correctly 19 00=
=2E So the problem is in the reading.
>
> I tried switching triple-sampling on and off, but it does not change =
anything.
>
> I observed the same issue on different physical devices, so it is not=
 an isolated issue.

Maybe the hardware does not work properly. Try lowering the SPI bus=20
frequency or other hw parameters.

Wolfgang.

>
> Julien
>
>> On 15 avr. 2016, at 12:19, Kurt Van Dijck <dev.kurt@vandijck-laurijs=
sen.be> wrote:
>>
>> I'm sure that your host does not introduce a problem.
>> The 80 00 appears on the wire. Your linux kernel can't change that :=
-)
>>
>> Can you validate your claim that this is erroneous?
>> Can you see these frames exactly the same on an other host?
>
