From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: PCAN-USB on 3v3 CAN
Date: Fri, 17 Nov 2017 19:03:14 +0100
Message-ID: <20171117180314.GA3799@airbook.vandijck-laurijssen.be>
References: <20171117132954.GA7355@airbook.vandijck-laurijssen.be>
 <VI1PR0302MB3325CE41756C19E9042B791BD62F0@VI1PR0302MB3325.eurprd03.prod.outlook.com>
 <01dc3e8c-9d59-3211-843a-fc2afe1672c3@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b02.edpnet.be ([212.71.1.222]:51027 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753307AbdKQSDS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 17 Nov 2017 13:03:18 -0500
Received: from zotac.vandijck-laurijssen.be (77.109.102.73.adsl.dyn.edpnet.net [77.109.102.73]) by relay-b02.edpnet.be with ESMTP id cil1anyKYmsgbnMV for <linux-can@vger.kernel.org>; Fri, 17 Nov 2017 19:03:16 +0100 (CET)
Received: from airbook.vandijck-laurijssen.be (kurt [IPv6:fd00::1610:9fff:fef4:c26])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 0F340439F49
        for <linux-can@vger.kernel.org>; Fri, 17 Nov 2017 19:03:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <01dc3e8c-9d59-3211-843a-fc2afe1672c3@posteo.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Thanks for your answers. I think have gathered enough argument
to change bitrate ...
923kBit must have been a mistake in the first place :-)

Kurt

--- Original message ---
> Date:   Fri, 17 Nov 2017 18:29:47 +0100
> From: Patrick Menschel <menschel.p@posteo.de>
> To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
> Subject: Re: PCAN-USB on 3v3 CAN
> User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
>  Thunderbird/52.4.0
> 
> Hi,
> 
> I can also confirm that mixing 3,3V and 5V transceivers has minimal
> effect on signal quality.
> The only measureable effect is the slightly reduced differential voltage.
> I have multiple SN65HVD230, MCP2551 and TJA1050 on the same CAN bus.
> 
> The only problem I know of are bias networks where CAN Hi is pulled to
> VCC and obviously you should not have a 5V and a 3,3V bias on the same wire.
> 
> Regards,
> Patrick
> 
> 
> 
> Am 17.11.2017 um 15:35 schrieb Rost, Martin:
> > Hi Kurt,
> > 
> > We're using both 5V transceivers (like TJA1040) and 3.3V tranceivers (like SN65HVD231) on the same busses for years, and I'm not having problems with them.
> > According to the datasheet the bus voltage adheres to the same standard ISO11898.
> > The 3.3V devices are more sensitive to voltage spikes, so shorting the bus lines to e.g. 24V kills your 3.3V transceiver for sure, while most 5V ones should survive.
> > 
> > There is a different CAN standard though, thas carries 12V on the bus lines. It's hard to find, and I have never seen anyone using it.
> > 
> > Regards
> > Martin 
> 
> Am 17.11.2017 um 15:41 schrieb Stéphane Grosjean:
> > Hi,
> > 
> > The 3V3 is not the problem but this weird bitrate is not supported by the PCAN-USB.
> > 
> > Regards,
> > 
> > Stephane
> > 
> > -----Original Message-----
> > From: linux-can-owner@vger.kernel.org [mailto:linux-can-owner@vger.kernel.org] On Behalf Of Kurt Van Dijck
> > Sent: vendredi 17 novembre 2017 14:30
> > To: linux-can@vger.kernel.org
> > Subject: PCAN-USB on 3v3 CAN
> > 
> > Hello,
> > 
> > I have difficulty connecting my PCAN-USB to a CAN network where all nodes have a 3v3 transceiver, and the obscure bitrate of 923kBit.
> > 
> > Since this is the first time I encountered a '3v3' CAN bus, I was a bit supprised. Will this work with my (I think) 5v PCAN-USB?
> > Is this transceiver voltage interchangeable?
> > 
> > Kind regards,
> > Kurt
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-can" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > --
> > PEAK-System Technik GmbH
> > Sitz der Gesellschaft Darmstadt - HRB 9183
> > Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm
> > --
> > N�����r��y���b�X��ǧv�^�)޺{.n�+����{�q���^n�r���z���h����&���G���h�(�階�ݢj"���m�����z�ޖ���f���h���~�mml==
> > 
> 


