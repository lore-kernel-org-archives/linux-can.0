From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: J1939 packet stuffing
Date: Tue, 22 Apr 2014 10:31:15 +0200
Message-ID: <20140422083115.GB12818@vandijck-laurijssen.be>
References: <loom.20140409T155830-71@post.gmane.org>
 <20140409194939.GD15221@vandijck-laurijssen.be>
 <loom.20140410T155519-838@post.gmane.org>
 <20140411083139.GB449@vandijck-laurijssen.be>
 <loom.20140417T051332-76@post.gmane.org>
 <20140417201835.GA12665@vandijck-laurijssen.be>
 <loom.20140421T164905-320@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay004.isp.belgacom.be ([195.238.6.170]:56035 "EHLO
	mailrelay004.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751261AbaDVIbS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 22 Apr 2014 04:31:18 -0400
Content-Disposition: inline
In-Reply-To: <loom.20140421T164905-320@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: swapnil <patilswa@gmail.com>
Cc: linux-can@vger.kernel.org

Hey,

On Mon, Apr 21, 2014 at 03:04:12PM +0000, swapnil wrote:
>=20
> without padding=20
> (1387768742.573470) can0 18EC00F9#100A00020200EF00
> (1387768742.574075) can0 18ECF900#110201FFFF00EF00
> (1387768742.574802) can0 18EB00F9#0100112233445566
> (1387768742.575741) can0 18EB00F9#02778899
> (1387768743.830696) can0 18EC00F9#FF03FFFFFF00EF00
>=20
> with padding reply
> (1387768780.530352) can0 18EC00F9#100E00020200EF00
> (1387768780.530957) can0 18ECF900#110201FFFF00EF00
> (1387768780.531675) can0 18EB00F9#0100112233445566
> (1387768780.532752) can0 18EB00F9#0277889911223344
> (1387768780.533427) can0 18ECF900#130E0002FF00EF00
>=20
> following lines from sae j1939
> 5.10.4 Transport Protocol=E2=80=94Data Transfer Message (TP.DT)
>=20
> Packetized Data (7 bytes). Note the last packet of a multipacket
> Parameter Group may require less than 8 data bytes. The extra bytes
> should be filled with FF.
>=20
> is it good to add in j1939 module ? or in my application=20

I'm aware of this rule in the spec.
I had expected that no ECU would ever complain about
missing stuffer bytes, as this appear a little stupid to me.
We passed the Isobus certification with this DLC < 8 thing.

Since you encountered such ECU, I must change opinion a little bit.

The right place to fix is not in userspace, but in the j1939 module.
I'll propose a patch soon that adds a modules parameter.
I'm thinking about adding a socket option, but I didn't find time yet.

Can you elaborate a bit on the ECU's that you found that expose this
behaviour? Which ECU's, which manufacturer, does all ECU's you found
have this behaviour?

Kurt
