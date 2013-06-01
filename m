From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] can: flexcan: remove HAVE_CAN_FLEXCAN Kconfig symbol
Date: Sat, 01 Jun 2013 10:59:03 +0200
Message-ID: <4297748.x0TtCUl2dJ@wuerfel>
References: <1368781157-4646-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1368781157-4646-1-git-send-email-mkl@pengutronix.de>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, U Bhaskar-B22300 <B22300@freescale.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>, linuxppc-dev@lists.ozlabs.org, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On Friday 17 May 2013 10:59:17 Marc Kleine-Budde wrote:
> This patch removes the Kconfig symbol HAVE_CAN_FLEXCAN from arch/{arm,powerpc}
> and allowing compilation unconditionally on all arm and powerpc platforms.
> 
> This brings a bigger compile time coverage and removes the following dependency
> warning found by Arnd Bergmann:
> 
>     warning: (SOC_IMX28 && SOC_IMX25 && SOC_IMX35 && IMX_HAVE_PLATFORM_FLEXCAN &&
>         SOC_IMX53 && SOC_IMX6Q) selects HAVE_CAN_FLEXCAN
>     which has unmet direct dependencies (NET && CAN && CAN_DEV)
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Kumar Gala <galak@kernel.crashing.org>
> Cc: U Bhaskar-B22300 <B22300@freescale.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks for addressing this!
