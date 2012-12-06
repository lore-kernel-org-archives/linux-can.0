From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [RFC v2 0/7] pch_can/c_can: fix races and add PCH support to c_can
Date: Thu, 06 Dec 2012 14:38:37 +0100
Message-ID: <4036287.fuKZ6k5idx@ws-stein>
References: <1354199987-10350-1-git-send-email-wg@grandegger.com> <4250988.UdN8LQq6de@ws-stein> <50BF85DD.6090809@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:35795 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752362Ab2LFNio (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Dec 2012 08:38:44 -0500
In-Reply-To: <50BF85DD.6090809@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, bhupesh.sharma@st.com, tomoya.rohm@gmail.com

Hello Wolfgang,

On Wednesday 05 December 2012 18:35:25, Wolfgang Grandegger wrote:
> >> - The messages look still ok (not currupted, I mean)?
> > 
> > The received frames all look good (despite wrong counter sometimes due to 
> > wrong order or lost frames).
> > 
> >>> Even worse, if I use the following patch to check if PCI writes were 
> >>> successfully, I notices that some writes (or the consecutive read) don't 
> >>> succeed. And I also get lots of I2C timeouts waiting for a xfer complete.
> >>
> >> Be careful, there might be some registers changing their values after
> >> writing. Can you show the value read after writing and the register
> >> offset? The influence on the I2C bus looks more like an overload or
> >> hardware problem. What is your CAN interrupt rate?
> > 
> > I get about 33 interrupts per second on i2c. On a successful run I get 366886 
> > interrupts for 500000 messages with the c_can driver.
> 
> In what time? Is the CAN bus highly loaded.

Busload is about 14-18% according to canbusload with 1MBit. A complete sucessful run takes about 5 minutes.

> > On the second line you can see that the register isn't written at all (or the 
> > read failed for some reason).
> 
> I assume the latter. Could you please retry reading the register until
> the correct value shows up. With some timeout, of course.

I notices having all error events printed on serial console using pch_uart driver has negative effect (I guess one problem causes another one), so I setup 'dmesg -n1' to reduce serial load before the test.
Running the test with just one heartbeat triggered LED set using I2C the test runs without errors. I only see
Lots of 'c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. got: 0x2000' at the beginning. It seems this (reserved?) bit is always 1 no matter what we write.
But things start to break when running the test while running 'watch sensors' (sensors queries several temperature sensors via I2C) in a seconds ssh session.
First off the driver error messages (omitting the messages as written above):
[  384.466217] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xbc
[  384.466630] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xb8
[  394.754389] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x0 failed. got: 0xac
[  394.754532] c_can_pci 0000:02:0c.3: can0: write 0x6 to offset 0x20 failed. got: 0x20
[  394.754798] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x98
[  429.851053] c_can_pci 0000:02:0c.3: can0: write 0x5 to offset 0x20 failed. got: 0x8
[  440.129098] c_can_pci 0000:02:0c.3: can0: write 0x9404 to offset 0x38 failed. got: 0x8
[  440.129496] c_can_pci 0000:02:0c.3: can0: write 0x1404 to offset 0x38 failed. got: 0x388
[  440.129765] c_can_pci 0000:02:0c.3: can0: write 0x9404 to offset 0x38 failed. got: 0x8
[  440.130441] c_can_pci 0000:02:0c.3: can0: write 0xa to offset 0x20 failed. got: 0x8
[  460.742395] c_can_pci 0000:02:0c.3: can0: write 0x1404 to offset 0x38 failed. got: 0x8
[  460.742662] c_can_pci 0000:02:0c.3: can0: write 0x90 to offset 0x24 failed. got: 0xa8
[  460.742789] c_can_pci 0000:02:0c.3: can0: write 0x4 to offset 0x20 failed. got: 0x8
[  460.742805] c_can_pci 0000:02:0c.3: can0: write 0x4 to offset 0x20 failed. got: 0x18
[  460.744112] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xb8
[  471.025367] c_can_pci 0000:02:0c.3: can0: write 0x9 to offset 0x20 failed. got: 0x18
[  493.714037] c_can_pci 0000:02:0c.3: can0: write 0xa to offset 0x20 failed. got: 0x18
[  493.714296] c_can_pci 0000:02:0c.3: can0: write 0xa to offset 0x20 failed. got: 0x8
[  493.714976] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x28
[  493.715788] c_can_pci 0000:02:0c.3: can0: write 0x1404 to offset 0x38 failed. got: 0x388
[  493.716243] c_can_pci 0000:02:0c.3: can0: write 0x1404 to offset 0x38 failed. got: 0x8
[  547.301509] c_can_pci 0000:02:0c.3: can0: write 0x1404 to offset 0x38 failed. got: 0x388
[  547.302181] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0x88
[  557.602229] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x0 failed. got: 0x88
[  557.602501] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x0 failed. got: 0x28
[  557.602773] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x0 failed. got: 0xa8
[  567.901158] c_can_pci 0000:02:0c.3: can0: write 0x1404 to offset 0x38 failed. got: 0x8
[  567.901558] c_can_pci 0000:02:0c.3: can0: write 0x1404 to offset 0x38 failed. got: 0x388
[  567.901821] c_can_pci 0000:02:0c.3: can0: write 0xb to offset 0x20 failed. got: 0x8
[  569.962867] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xa0
[  572.024462] c_can_pci 0000:02:0c.3: can0: write 0x10 to offset 0x20 failed. got: 0x8
[  572.024731] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0x28
[  576.150457] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x88
[  576.150730] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0x28
[  576.151463] c_can_pci 0000:02:0c.3: can0: write 0x10 to offset 0x20 failed. got: 0x18
[  576.151716] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x28
[  576.151987] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0xa8
[  578.222888] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x28
[  578.224252] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x88
[  580.284468] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x88
[  580.284741] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0x28
[  580.285969] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0xa8
[  580.286226] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x88
[  582.348458] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x88
[  582.348730] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0x28
[  582.348878] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x0 failed. got: 0xa0
[  582.349494] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x0 failed. got: 0x88
[  582.350354] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0x88
[  584.410064] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x28
[  584.410455] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x88
[  584.410725] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0x28
[  586.478397] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xb8
[  586.478662] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xac
[  588.551484] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x98
[  588.552464] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xb8
[  588.552720] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x28
[  588.552991] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0xa8
[  590.624880] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x28
[  592.695613] c_can_pci 0000:02:0c.3: can0: write 0x10 to offset 0x20 failed. got: 0x8
[  592.696377] c_can_pci 0000:02:0c.3: can0: write 0x1 to offset 0x20 failed. got: 0x8
[  594.759455] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x88
[  594.759727] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0x28
[  594.760696] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x28
[  596.821041] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0xac
[  596.821433] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0x88
[  596.822423] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x0 failed. got: 0x88
[  596.822683] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x0 failed. got: 0x28
[  598.901376] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xbc
[  598.901517] c_can_pci 0000:02:0c.3: can0: write 0x10 to offset 0x20 failed. got: 0x20
[  600.962052] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x28
[  600.962728] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0x28
[  603.050703] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xb8
[  603.050967] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xac
[  605.146593] c_can_pci 0000:02:0c.3: can0: write 0x10 to offset 0x20 failed. got: 0x18
[  605.146855] c_can_pci 0000:02:0c.3: can0: write 0x10 to offset 0x20 failed. got: 0x8
[  607.207808] c_can_pci 0000:02:0c.3: can0: write 0x7 to offset 0x20 failed. got: 0x8
[  607.209239] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x88
[  609.287327] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x98
[  609.287589] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x28
[  611.349466] c_can_pci 0000:02:0c.3: can0: write 0x10 to offset 0x20 failed. got: 0x18
[  611.349721] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x28
[  611.349993] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0xa8
[  613.411182] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xa0
[  613.411451] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xb8
[  613.411714] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xac
[  613.413185] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x88
[  615.473479] c_can_pci 0000:02:0c.3: can0: write 0x10 to offset 0x20 failed. got: 0x18
[  615.473739] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xac
[  617.547060] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xac
[  617.547452] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x88
[  617.547723] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0x28
[  619.610167] c_can_pci 0000:02:0c.3: can0: write 0x1404 to offset 0x38 failed. got: 0x388
[  619.610897] c_can_pci 0000:02:0c.3: can0: write 0x1404 to offset 0x38 failed. got: 0x84
[  621.674433] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x28
[  621.674827] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0x88
[  623.736136] c_can_pci 0000:02:0c.3: can0: write 0x10 to offset 0x20 failed. got: 0x18
[  623.736389] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x28
[  623.736661] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0xa8
[  625.797476] c_can_pci 0000:02:0c.3: can0: write 0x10 to offset 0x20 failed. got: 0x18
[  625.798001] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x0 failed. got: 0xa8
[  625.798721] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xbc
[  627.878566] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xb8
[  627.878831] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xac
[  629.979482] c_can_pci 0000:02:0c.3: can0: write 0x10 to offset 0x20 failed. got: 0x18
[  629.979735] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x28
[  632.053216] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xa0
[  632.053486] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xb8
[  632.053739] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x28
[  632.055326] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x88
[  634.116321] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x28
[  634.116730] c_can_pci 0000:02:0c.3: can0: write 0x1404 to offset 0x38 failed. got: 0x388
[  638.241495] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xb8
[  638.241757] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xac
[  638.243102] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xa8
[  640.303328] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0xa8
[  642.386078] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xb8
[  642.386342] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xac
[  644.498061] c_can_pci 0000:02:0c.3: can0: write 0x10 to offset 0x20 failed. got: 0x8
[  644.498329] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xa8
[  644.498476] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xb8
[  644.498729] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x28
[  644.499000] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0xa8
[  646.662057] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xbc
[  646.663432] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x0 failed. got: 0x88
[  648.726341] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0xa8
[  648.726475] c_can_pci 0000:02:0c.3: can0: write 0x10 to offset 0x20 failed. got: 0x18
[  648.726742] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0x28
[  648.728303] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x88
[  650.900856] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x0 failed. got: 0x88
[  650.901394] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x0 failed. got: 0xac
[  650.901538] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x0 failed. got: 0xa0
[  655.024046] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x28
[  655.024316] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xa8
[  655.024465] c_can_pci 0000:02:0c.3: can0: write 0x10 to offset 0x20 failed. got: 0x18
[  655.024999] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0xa8
[  657.189061] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0x28
[  657.189453] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0x88
[  657.190518] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x88
[  657.190787] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0x28
[  659.251734] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x28
[  659.251875] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xa0
[  659.252407] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x0 failed. got: 0x88
[  663.484251] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xb8
[  663.484516] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xac
[  665.544773] c_can_pci 0000:02:0c.3: can0: write 0x10 to offset 0x20 failed. got: 0x18
[  665.546173] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xa0
[  665.546443] c_can_pci 0000:02:0c.3: can0: write 0x10 to offset 0x20 failed. got: 0x18
[  665.546699] c_can_pci 0000:02:0c.3: can0: write 0x10 to offset 0x20 failed. got: 0x8
[  665.546845] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0xa0
[  667.608301] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0x28
[  669.671155] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x88
[  671.732041] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0x28
[  671.732311] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0xa8
[  671.732434] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x88
[  671.732450] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xb8
[  671.732708] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xbc
[  671.732978] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0xa8
[  671.733784] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x88
[  673.794056] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0xac
[  673.794317] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0xa8
[  673.794441] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x88
[  673.794457] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xb8
[  673.794715] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xbc
[  673.794853] c_can_pci 0000:02:0c.3: can0: write 0x10 to offset 0x20 failed. got: 0x20
[  673.796066] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x28
[  673.796463] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0x88
[  675.856075] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xac
[  675.856466] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x88
[  675.856736] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0x28
[  677.918058] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xbc
[  680.001185] c_can_pci 0000:02:0c.3: can0: write 0x10 to offset 0x20 failed. got: 0x18
[  680.001444] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x28
[  682.060763] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x0 failed. got: 0xa8
[  682.061048] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x0 failed. got: 0xac
[  682.062648] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xbc
[  682.062787] c_can_pci 0000:02:0c.3: can0: write 0x10 to offset 0x20 failed. got: 0x20
[  684.138124] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xb8
[  686.199499] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xb8
[  686.199895] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0xa0
[  688.261491] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xb8
[  688.262607] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x28
[  688.262879] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0xa8
[  688.263001] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x88
[  690.323491] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xb8
[  690.323754] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xac
[  692.384770] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x98
[  692.386036] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x0 failed. got: 0xac
[  692.386445] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x0 failed. got: 0xa8
[  692.386692] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0x28
[  692.386839] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x0 failed. got: 0xa0
[  694.447059] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x0 failed. got: 0xac
[  694.447320] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0xa8
[  694.447443] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x88
[  694.447459] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xb8
[  694.447715] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x28
[  694.447985] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0xa8
[  694.449055] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x28
[  694.449327] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0xa8
[  694.449450] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0x88
[  696.508763] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xb8
[  696.509050] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xac
[  696.509586] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x0 failed. got: 0xa8
[  696.509706] c_can_pci 0000:02:0c.3: can0: write 0x10 to offset 0x20 failed. got: 0x8
[  696.509971] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0x28
[  696.510954] c_can_pci 0000:02:0c.3: can0: write 0x10 to offset 0x20 failed. got: 0x8
[  696.511223] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xa0
[  698.571318] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0xa8
[  698.572681] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. got: 0xa8
[  700.646608] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. got: 0x28
[  700.647000] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x0 failed. got: 0x88

As you can see, sometimes it needs several write retries to succeed. Nevertheless my test application detects also some problems:
> Error on MSG ID 0x252. Got counter 96480 and expected 96466
> Error on MSG ID 0x251. Got counter 96480 and expected 96466
> Error on MSG ID 0x252. Got counter 101706 and expected 101696
> Error on MSG ID 0x251. Got counter 101706 and expected 101696
Here were messages missed/dropped for both CAN-IDs.
> Error on MSG ID 0x251. Got counter 108673 and expected 108672
> Error on MSG ID 0x251. Got counter 108672 and expected 108674
> Error on MSG ID 0x251. Got counter 108674 and expected 108673
                                     ^^^^^^
Here you can see the CAN frame with counter 108673 is read before 108672.
> Error on MSG ID 0x251. Got counter 117488 and expected 117487
> Error on MSG ID 0x251. Got counter 117487 and expected 117489
> Error on MSG ID 0x251. Got counter 117489 and expected 117488
                                     ^^^^^^
Here you can see the CAN frame with counter 117488 is read before 117487.
> Error on MSG ID 0x251. Got counter 142297 and expected 142296
> Error on MSG ID 0x251. Got counter 142296 and expected 142298
> Error on MSG ID 0x251. Got counter 142298 and expected 142297
Same again.
> Error on MSG ID 0x251. Got counter 147932 and expected 147924
> Error on MSG ID 0x251. Got counter 147936 and expected 147933
> Error on MSG ID 0x252. Got counter 147936 and expected 147924
> Error on MSG ID 0x251. Got counter 165268 and expected 165267
> Error on MSG ID 0x251. Got counter 218560 and expected 218558
> Error on MSG ID 0x252. Got counter 218560 and expected 218558
> Error on MSG ID 0x252. Got counter 231076 and expected 231075
> Error on MSG ID 0x251. Got counter 231077 and expected 231076
> Error on MSG ID 0x251. Got counter 241959 and expected 241958
Messages missed/dropped again.

Below is the patch for c_can.

Best regards,
Alexander

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index d63aaa3..da9bbc0 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -1186,6 +1186,7 @@ struct net_device *alloc_c_can_dev(void)
                                        CAN_CTRLMODE_BERR_REPORTING;
 
        spin_lock_init(&priv->lock);
+       spin_lock_init(&priv->testlock);
 
        return dev;
 }
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index 3487d5e..2b58b75 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -173,6 +173,7 @@ struct c_can_priv {
        unsigned int instance;
        void (*init) (const struct c_can_priv *priv, bool enable);
        spinlock_t lock;        /* to protect tx and rx message objects */
+       spinlock_t testlock;    /* to protect tx and rx message objects */
 };
 
 struct net_device *alloc_c_can_dev(void);
diff --git a/drivers/net/can/c_can/c_can_pci.c b/drivers/net/can/c_can/c_can_pci.c
index 2516ea9..0ac4d43 100644
--- a/drivers/net/can/c_can/c_can_pci.c
+++ b/drivers/net/can/c_can/c_can_pci.c
@@ -74,13 +74,37 @@ static void c_can_pci_write_reg_aligned_to_32bit(struct c_can_priv *priv,
 static u16 c_can_pci_read_reg_32bit(struct c_can_priv *priv,
                                    enum reg index)
 {
-       return (u16)ioread32(priv->base + 2 * priv->regs[index]);
+       unsigned long flags;
+       u16 reg;
+
+       spin_lock_irqsave(&priv->testlock, flags);
+       reg = (u16)ioread32(priv->base + 2 * priv->regs[index]);
+       spin_unlock_irqrestore(&priv->testlock, flags);
+
+       return reg;
 }
 
 static void c_can_pci_write_reg_32bit(struct c_can_priv *priv,
                                      enum reg index, u16 val)
 {
-       iowrite32((u32)val, priv->base + 2 * priv->regs[index]);
+       u16 reg;
+       unsigned long flags;
+       int retries;
+
+       retries = 0;
+
+       spin_lock_irqsave(&priv->testlock, flags);
+
+       do
+       {
+               iowrite32((u32)val, priv->base + 2 * priv->regs[index]);
+               reg = (u16)ioread32(priv->base + 2 * priv->regs[index]);
+               if (reg != val)
+               {
+                       netdev_err(priv->dev, "write 0x%x to offset 0x%x failed. got: 0x%x\n", val, 2 * priv->regs[index], reg);
+               }
+       } while ((reg != val) && (retries++ < 20));
+       spin_unlock_irqrestore(&priv->testlock, flags);
 }
 
 static void c_can_pci_reset_pch(const struct c_can_priv *priv, bool enable)

