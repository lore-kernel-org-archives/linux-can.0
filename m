From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: AW: [PATCH v3 1/1] can: Add support for esd CAN PCIe/402 card
Date: Wed, 05 Nov 2014 10:12:49 +0100
Message-ID: <5459EA11.4060600@hartkopp.net>
References: <1415080039-38327-1-git-send-email-thomas.koerper@esd.eu> <5458D372.3020604@hartkopp.net> <5458D403.9040803@pengutronix.de> <8CE1D0B9BFD2404DA079DDE1814A6F2E02BB65D1BB24@esd-s3.esd.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:59894 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396AbaKEJNB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 5 Nov 2014 04:13:01 -0500
In-Reply-To: <8CE1D0B9BFD2404DA079DDE1814A6F2E02BB65D1BB24@esd-s3.esd.local>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?windows-1252?Q?Thomas_K=F6rper?= <Thomas.Koerper@esd.eu>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 05.11.2014 05:21, Thomas K=F6rper wrote:

> already was afraid the module param should be removed :)
> May I print all these infos unconditionally?  ...If someone has
> trouble with the card we really like to see that stuff first.

Oh. It's no problem to print hardware specific information at startup.
But this is IMO only too much because of it's formatting

+	if (dump_infos) {
+		dev_info(dev, "  Probe register: 0x%.8x\n",
+			 acc_ov_read32(ov, ACC_OV_OF_PROBE));
+		dev_info(dev, "  Features: 0x%.4x\n", ov->features);
+		dev_info(dev, "  FPGA Version: 0x%.4x\n",
+			 ov->version);
+		dev_info(dev, "  Strappings: 0x%.4x\n",
+			 acc_ov_read32(ov, ACC_OV_OF_INFO) >> 16);
+		dev_info(dev, "  Active cores: %u\n",
+			 ov->active_cores);
+		dev_info(dev, "  Total cores: %u\n",
+			 ov->total_cores);
+		dev_info(dev, "  Core frequency: %u\n",
+			 ov->core_frequency);
+		dev_info(dev, "  Timestamp frequency: %u\n",
+			 ov->timestamp_frequency);
+	}

What about putting these information in just one or two lines, e.g.

esdacc: FPGA rev x.xx @ 3000Hz (TS @ 400Hz), probe reg x.xx, feat. x.xx=
, X of Y cores active=20

>=20
> And about the commit message: maybe
> "This patch adds support for the CAN PCIe/402 card from esd electroni=
c
> system design gmbh. FPGA based CAN controller, supporting up to 4
> nets, MSI and bus mastering, see http://esd.eu/en/products/can-pcie40=
2
> for details."?, or something specific you're missing?

Looks better :-)

Regards,
Oliver

