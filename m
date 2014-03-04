From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v11 0/7] Add CAN FD infrastructure for CAN driver
Date: Tue, 04 Mar 2014 23:17:45 +0100
Message-ID: <9212ed8d-717a-462c-ae61-261db554ca48@email.android.com>
References: <1393970417-15399-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:35704 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755769AbaCDWRm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Mar 2014 17:17:42 -0500
In-Reply-To: <1393970417-15399-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de



On 4. M=C3=A4rz 2014 23:00:10 MEZ, Marc Kleine-Budde <mkl@pengutronix.d=
e> wrote:
>Again, it's me messing in Oliver's patches.
>

:-)

tnx.
looks better now. Your changes made it even clearer.

=46inal nitpick:
The commit msg in 4/7 regarding the simplification could be removed as =
you moved that part to 3/7 now.

Cheers,=20
Oliver

>changes since v10
>- 5/7: Re-add call to priv->do_set_data_bittiming().
>- 6/7 + 7/7: don't touch "if (data[IFLA_CAN_DATA_BITTIMING])" in 7/7,
>but in 6/7
>
>Marc
>


