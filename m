From: Michael Pellegrini <mikep86@gmail.com>
Subject: Re: =?utf-8?b?cGNoX2Nhbjo=?= Data transmission stops after dropped packet
Date: Tue, 11 Dec 2012 14:46:37 +0000 (UTC)
Message-ID: <loom.20121211T153556-802@post.gmane.org>
References: <loom.20121114T160521-534@post.gmane.org> <50ACABE2.2020306@grandegger.com> <50C0B05F.7020606@grandegger.com> <2331999.ZYFOYXdjyx@ws-stein> <50C1160A.20203@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:51718 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752900Ab2LKOq7 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 11 Dec 2012 09:46:59 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1TiR6y-00048M-Eh
	for linux-can@vger.kernel.org; Tue, 11 Dec 2012 15:47:08 +0100
Received: from 96.45.208.254 ([96.45.208.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 11 Dec 2012 15:47:08 +0100
Received: from mikep86 by 96.45.208.254 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 11 Dec 2012 15:47:08 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Wolfgang Grandegger <wg <at> grandegger.com> writes:

> To summarize my understanding of your problem(s). As long as there are
> no I2C transfers, everything works fine, right? The patch below does
> report some write-readback failures but that's due to reserved read-only
> bits. I assume t hat you also use my "RFC v2" patches for c_can.
> 
> Trouble starts with concurrent I2C transfers. Then the protected
> write-readback test fails, which I regard as abnormal hardware behavior,
> resulting in message losses and out-of-order reception.
> 
> Would be interesting to compare the hardware. Michael, could you also
> show the output of "lspci -vv".

I applied the patch provided.  On driver load, dmesg reports the following:

[  379.817717] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.817733] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.817856] c_can_pci 0000:02:0c.3: can0: obj no:6, msgval:0x0000003f
[  379.817875] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.817891] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.817907] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.817923] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.817939] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.817955] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.817971] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.817987] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818003] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818019] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818035] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818051] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818067] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818082] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818098] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818114] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818130] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818146] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818162] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818178] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818194] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818228] c_can_pci 0000:02:0c.3: can0: obj no:7, msgval:0x0000007f
[  379.818246] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818262] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818278] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818294] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818310] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818326] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818342] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818358] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818374] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818390] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818406] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818422] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818437] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818453] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818469] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818485] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818501] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818517] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818533] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818549] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818565] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818599] c_can_pci 0000:02:0c.3: can0: obj no:8, msgval:0x000000ff
[  379.818617] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818634] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818650] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818665] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818679] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818694] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818709] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818724] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818739] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818754] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818769] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818784] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818799] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818814] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818828] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818844] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818858] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818873] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818888] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818903] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818918] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818951] c_can_pci 0000:02:0c.3: can0: obj no:9, msgval:0x000001ff
[  379.818968] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818983] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.818998] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819013] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819028] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819043] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819058] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819073] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819088] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819103] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819118] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819133] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819148] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819163] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819178] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819193] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819208] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819223] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819238] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819253] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819268] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819301] c_can_pci 0000:02:0c.3: can0: obj no:10, msgval:0x000003ff
[  379.819318] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819333] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819348] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819362] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819377] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819393] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819409] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819426] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819442] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819457] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819473] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819488] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819504] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819519] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819534] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819550] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819565] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819581] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819596] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819612] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819627] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819661] c_can_pci 0000:02:0c.3: can0: obj no:11, msgval:0x000007ff
[  379.819678] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819694] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819710] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819726] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819742] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819758] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819774] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819790] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819806] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819822] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819838] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819854] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819869] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819885] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819901] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819917] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819933] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819949] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819965] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819981] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.819997] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820075] c_can_pci 0000:02:0c.3: can0: obj no:12, msgval:0x00000fff
[  379.820093] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820110] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820125] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820142] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820157] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820173] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820189] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820205] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820221] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820237] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820252] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820268] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820284] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820300] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820316] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820332] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820348] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820364] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820380] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820396] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820412] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820446] c_can_pci 0000:02:0c.3: can0: obj no:13, msgval:0x00001fff
[  379.820464] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820480] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820496] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820512] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820528] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820544] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820560] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820576] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820591] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820607] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820623] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820639] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820655] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820671] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820687] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820703] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820719] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820734] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820750] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820766] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820782] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820817] c_can_pci 0000:02:0c.3: can0: obj no:14, msgval:0x00003fff
[  379.820835] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820851] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820867] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820883] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820899] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820915] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820930] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820946] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820962] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820978] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.820994] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.821010] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.821026] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.821042] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.821058] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.821073] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.821089] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.821105] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.821121] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.821137] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.821153] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.821187] c_can_pci 0000:02:0c.3: can0: obj no:15, msgval:0x00007fff
[  379.821205] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.821221] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.821237] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.821253] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.821269] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.821285] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.821301] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.821317] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.821332] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.821348] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.821364] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.821380] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.821397] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.821413] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.821428] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.821445] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.821460] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.821475] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.821490] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.821505] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.821520] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
got: 0x2000
[  379.821553] c_can_pci 0000:02:0c.3: can0: obj no:16, msgval:0x0000ffff
[  379.821568] c_can_pci 0000:02:0c.3: can0: setting BTR=0518 BRPE=0000

"lspci -vv" reports:

02:0c.2 Serial bus controller [0c80]: Intel Corporation Platform Controller Hub 
EG20T I2C Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin C routed to IRQ 7
        Region 1: Memory at d0144000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] MSI: Enable- Count=1/1 Maskable- 64bit-
                Address: 00000000  Data: 0000
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-
,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

02:0c.3 CANBUS: Intel Corporation Platform Controller Hub EG20T Controller Area 
Network (CAN) Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin C routed to IRQ 42
        Region 1: Memory at d0143000 (32-bit, non-prefetchable) [size=512]
        Capabilities: [40] MSI: Enable+ Count=1/1 Maskable- 64bit-
                Address: fee0300c  Data: 4179
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-
,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: c_can_pci
        Kernel modules: c_can_pci

Based on a quick test, the CAN interface appears functional with this driver.
However, I am unable to test the I2C interface as I can't get I2C devices to
appear in /dev right now.

I apologize for the delay in getting these results back to you.

- Mike

