From: Federico Vaga <federico.vaga@gmail.com>
Subject: generic module for c-can on pci
Date: Mon,  4 Jun 2012 15:32:45 +0200
Message-ID: <1338816766-7089-1-git-send-email-federico.vaga@gmail.com>
References: <4FC135C6.5030206@grandegger.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53020 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105Ab2FDNbR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 4 Jun 2012 09:31:17 -0400
In-Reply-To: <4FC135C6.5030206@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Federico Vaga <federico.vaga@gmail.com>, Giancarlo Asnaghi <giancarlo.asnaghi@st.com>, Alan Cox <alan@linux.intel.com>, Alessandro Rubini <rubini@gnudd.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org


As suggested I developed a generic module for C-CAN
on PCI. Probably I will do some changes about our
specific board, but I think that the module is generic
enough.
