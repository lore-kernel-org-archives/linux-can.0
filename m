Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84880A9
	for <linux-can@vger.kernel.org>; Tue,  5 Dec 2023 09:10:25 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rAYw9-000794-7P; Tue, 05 Dec 2023 18:10:21 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rAYw8-00Dn2f-CA; Tue, 05 Dec 2023 18:10:20 +0100
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rAYw8-005QXO-9O; Tue, 05 Dec 2023 18:10:20 +0100
Date: Tue, 5 Dec 2023 18:10:20 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: xingwei lee <xrivendell7@gmail.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org, mkl@pengutronix.de, robin@protonic.nl,
	socketcan@hartkopp.net, stable@vger.kernel.org,
	syzbot+daa36413a5cedf799ae4@syzkaller.appspotmail.com
Subject: Re: [PATCH v1] net: can: j1939: enhanced error handling for tightly
 received RTS messages in xtp_rx_rts_session_new
Message-ID: <20231205171020.GM981228@pengutronix.de>
References: <CABOYnLyMUdDvfUNcTS+1xQ+cVFjMO8jjzuTVjk7aoeje_Gw9Sw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABOYnLyMUdDvfUNcTS+1xQ+cVFjMO8jjzuTVjk7aoeje_Gw9Sw@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Hi,

On Mon, Dec 04, 2023 at 11:25:40PM +0800, xingwei lee wrote:
> Hello, Oleksij.
> I have reproduced this bug with repro.c

I assume, with this patch the reproduce will trigger only warning
instead of backtrace. Correct?

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
