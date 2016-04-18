From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Bad reading from mcp2515 with j1939
Date: Mon, 18 Apr 2016 07:48:50 +0200
Message-ID: <57147542.20208@grandegger.com>
References: <136B5347-DD98-4021-98C5-2FD18FC925A4@anemomind.com>
 <20160415101957.GA22129@airbook.vandijck-laurijssen.be>
 <4C069C3C-A7B8-4D3D-BA66-0D2140E93996@anemomind.com>
 <57110047.3040305@grandegger.com>
 <86B92DF4-DB93-457E-8BFB-7FA1BBBE2B4D@anemomind.com>
 <5711180D.8090407@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy01.manitu.net ([217.11.48.140]:42934 "EHLO
	mailproxy01.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727AbcDRFtB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 18 Apr 2016 01:49:01 -0400
In-Reply-To: <5711180D.8090407@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Julien Pilet <julien@anemomind.com>
Cc: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Am 15.04.2016 um 18:34 schrieb Wolfgang Grandegger:
> Hello,
>
> Am 15.04.2016 um 18:25 schrieb Julien Pilet:
>> Hi,
>>
>> Thanks a lot for your help, I found the error. There was a resistor
>> that was not supposed to be there (120ohms between CANH and CANL).
>> Removing it solved the problem.
>
> Well, the mcp2515 should read wrong data even with improper bus
> termination.

s/should/should *not*/. of course!

> Anyway, have a nice weekend as well.
>
> Wolfgang.
