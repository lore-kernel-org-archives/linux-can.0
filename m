From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: Bad reading from mcp2515 with j1939
Date: Fri, 15 Apr 2016 12:19:57 +0200
Message-ID: <20160415101957.GA22129@airbook.vandijck-laurijssen.be>
References: <136B5347-DD98-4021-98C5-2FD18FC925A4@anemomind.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b03.edpnet.be ([212.71.1.220]:39562 "EHLO
	relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbcDOKW6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 15 Apr 2016 06:22:58 -0400
Content-Disposition: inline
In-Reply-To: <136B5347-DD98-4021-98C5-2FD18FC925A4@anemomind.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Julien Pilet <julien@anemomind.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

> Hi,
> 
> I am using a MCP2515 for a nautical application. It turns out that in my lab, everything goes fine. On two boats, though, I get strange readings from can0.
> 
> I connected the MCP2515 to a sensor reporting a boat speed of 0 m/s.
>   can0  09F50323   [8]  79 00 00 FF FF 00 FF FF
> 
> The first data byte is the sequence ID, it is incremented in each packet.
> The two following bytes encode the boat speed.

If you say so :-)
This kind of application logic is kept outside the kernel.

> 
> candump gives me the following:
> 
>   can0  09F50323   [8]  7A 00 00 FF FF 00 FF FF
>   can0  09F50323   [8]  7B 00 00 FF FF 00 FF FF
>   can0  09F50323   [8]  7C 00 00 FF FF 00 FF FF
>   can0  09F50323   [8]  7D 00 00 FF FF 00 FF FF
>   can0  09F50323   [8]  7E 00 00 FF FF 00 FF FF
>   can0  09F50323   [8]  7F 00 00 FF FF 00 FF FF
>   can0  09F50323   [8]  80 80 00 FF FF 00 FF FF
>   can0  09F50323   [8]  81 00 00 FF FF 00 FF FF
>   can0  09F50323   [8]  82 80 00 FF FF 00 FF FF
>   can0  09F50323   [8]  83 00 00 FF FF 00 FF FF
>   can0  09F50323   [8]  84 80 00 FF FF 00 FF FF
>   can0  09F50323   [8]  85 00 00 FF FF 00 FF FF
>   can0  09F50323   [8]  86 80 00 FF FF 00 FF FF
> 
> Suddenly, when SID reaches 0x80, the speed is not 0 anymore: it is 0x0080 (encoded little endian 80 00). This is clearly wrong.
> I observed similar problems with sensors of different manufacturers, so I do not think the sensor is faulty. 
> The pattern repeats: for seq ID between 00 and 0x79, everything works fine. For seq ID 0x80 - 0xFA (the last seq ID sent) every packet with an even sequence ID has a spurious bit set in the 2nd byte.

I'm sure that your host does not introduce a problem.
The 80 00 appears on the wire. Your linux kernel can't change that :-)

Can you validate your claim that this is erroneous?
Can you see these frames exactly the same on an other host?

> I failed to reproduce the error in the lab, so it is hard for me to plug a oscilloscope and observe what is going on. I observe no error when transmitting the same data on my test network (which is much shorter and simpler than a real one).

It is often like that. Problems like to hide themselves.

Kurt
