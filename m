From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: CAN network drivers
Date: Sun, 5 Jul 2020 12:34:55 +0200
Message-ID: <7d4f2aa8-b63a-1c2d-961f-3ab1dbb386cd@pengutronix.de>
References: <20200705075606.22802-1-grandmaster@al2klimov.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200705075606.22802-1-grandmaster@al2klimov.de>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: "Alexander A. Klimov" <grandmaster@al2klimov.de>, wg@grandegger.com, davem@davemloft.net, kuba@kernel.org, robh+dt@kernel.org, dmurphy@ti.com, sriram.dash@samsung.com, hpeter@gmail.com, masahiroy@kernel.org, leon@kernel.org, krzk@kernel.org, kvalo@codeaurora.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On 7/5/20 9:56 AM, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>           If both the HTTP and HTTPS versions
>           return 200 OK and serve the same content:
>             Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

regards,
Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
