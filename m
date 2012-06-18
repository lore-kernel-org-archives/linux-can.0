From: Federico Vaga <federico.vaga@gmail.com>
Subject: Re: [PATCH] c_can_pci: generic module for C_CAN/D_CAN on PCI
Date: Mon, 18 Jun 2012 23:23:35 +0200
Message-ID: <CAH5GJ0p_9x_6sSN=UQW0Wh57LKGKwXnAiO+8UoB=Ex88gNWQsg@mail.gmail.com>
References: <1339674222-27699-1-git-send-email-federico.vaga@gmail.com> <4FDF83A5.6060703@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61738 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753473Ab2FRVX4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 18 Jun 2012 17:23:56 -0400
In-Reply-To: <4FDF83A5.6060703@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Giancarlo Asnaghi <giancarlo.asnaghi@st.com>, Alan Cox <alan@linux.intel.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Bhupesh SHARMA <bhupesh.sharma@st.com>, AnilKumar Chimata <anilkumar@ti.com>, Alessandro Rubini <rubini@gnudd.com>

> I get this warning:
>
> socketcan/linux/drivers/net/can/c_can/c_can_pci.c: In function 'c_can=
_pci_probe':
> socketcan/linux/drivers/net/can/c_can/c_can_pci.c:71: warning: 'priv'=
 may be used uninitialized in this function
>
> What about:
>
> - =C2=A0 =C2=A0 =C2=A0 pci_iounmap(pdev, priv->base);
> + =C2=A0 =C2=A0 =C2=A0 pci_iounmap(pdev, addr);

I didn't get this warning, but I read again the code and the warning
is correct, so pci_iounmap(pdev, addr) is the right way.

--=20
=46ederico Vaga
