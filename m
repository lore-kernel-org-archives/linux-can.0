Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D89D31D366;
	Sat,  3 Oct 2026 23:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791068442; cv=none; b=DVXTISmO8ChDhwstCyS7sXN7Ceu9h4Y7tQsCv3RmajY8pjxWwfbG1QjWpSsbhacOVBBmXxH4cekNItSB1nU49y2lggzr7nmKO7O1x0KSOtsNNMuekRW6lgWvkfyq9kS5l0h8tuMfx5ENncbOLfd4XzBJgt/fwj43YyLBBYpGVOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791068442; c=relaxed/simple;
	bh=D5VxQT6U3+k1DlSWZLyRVSJLp63vVCmSicgzsk+x6k8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kWV+9k6l1/29agC/P0SwwSdPHZV0FG4K5tKPabvI27h9sClSSxfO6hDCV8wT2GTajlsp909szUYZhGCB9ESRCS/X6asOnnvGfDOqSGt0PbMh+3jF+ovZzgvA7JqDEY3cp4q20qov6GLYlTgb1JHtmEJAxhrlMrPWTTxxMH4xYvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KX9mQZQK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KX9mQZQK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 974BD1F0089B;
	Sat,  3 Oct 2026 23:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791068441;
	bh=F2xhRCXMbw/C1p79BK4nhF5/CZZGztBgCVjeUWMlpgg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KX9mQZQK77QF/ntpYR/N/YctmYurHsAL3Vna6T0ABE/PE804dZZ0WqTIt6pUo67JE
	 Ie8LnHrcC1TxBepnSo/WPfZtO+07BHYQL3lGdZ6n5cct+jvORr9DOxBDaGX84kyzIY
	 n3zWTLcXVKYK1gINgU1zTWZMJdkHqAV8bRNzICrvyVGewHQb0PM55D8trAWwQRDch9
	 crjXLd/jujHuf9fcpyX4fL6pE/39Jpi176R7WwqyQkzRH4mq4+sLHFMfPyQNg2KsXJ
	 J73VuIpdYSgfxzylyixRk2DyfPxDc9ODP2cREMQUhD4khuq0r17Blp+YU1r9NY0l3q
	 ZhEs73ge1+VFA==
Subject:
 Re: [PATCH can-next 4/7] can: peak_usb: Add PCAN-USB bus errors reporting
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: mailhol@kernel.org, s.grosjean@peak-system.fr, kernel@pengutronix.de,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Sat, 03 Oct 2026 23:00:40 +0000
Message-ID: <179106844011.1406898.9142594030891687932@kernel.org>
In-Reply-To: <20261002-peak_usb_enhancements-v1-4-50e965755c06@pengutronix.de>
References: <20261002-peak_usb_enhancements-v1-4-50e965755c06@pengutronix.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch quietly fixes an existing slab out-of-bounds read
  in pcan_usb_handle_bus_evt()…
- [Medium] The patch adds PCAN_USB_ERR_ECC (0x01, which the patch itself
  documents as 'ask for BERR') to PCAN_USB_BERR_MASK.
- [Low] Several comments in drivers/net/can/usb/peak_usb/pcan_usb.c are
  stale or contradictory after this patch.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  pcan_usb_decode_msg() (drivers/net/can/usb/peak_usb/pcan_usb.c, line…

--

can: peak_usb: Add PCAN-USB bus errors reporting

This patch adds CAN bus error reporting to the PCAN-USB driver. It asks the
firmware for SJA1000 ECC reports and turns them into CAN_ERR_BUSERROR
frames in pcan_usb_handle_bus_evt(). It also advertises
CAN_CTRLMODE_BERR_REPORTING in ctrlmode_supported.

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
> index 169c00d93463c..e71ed7879c04e 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
> @@ -115,6 +115,7 @@
>  #define PCAN_USB_REC_BUSEVT		5
>
>  /* CAN bus events notifications selection mask */
> +#define PCAN_USB_ERR_ECC		0x01	/* ask for BERR */
>  #define PCAN_USB_ERR_RXERR		0x02	/* ask for rxerr counter */
>  #define PCAN_USB_ERR_TXERR		0x04	/* ask for txerr counter */
>
> @@ -122,11 +123,20 @@
>   * In other words, its interest is to know which side among rx and tx is
>   * responsible of the change of the bus state.
>   */
> -#define PCAN_USB_BERR_MASK	(PCAN_USB_ERR_RXERR | PCAN_USB_ERR_TXERR)
> +#define PCAN_USB_BERR_MASK	(PCAN_USB_ERR_ECC | \
> +				 PCAN_USB_ERR_RXERR | PCAN_USB_ERR_TXERR)

[Severity: Medium]
Can berr-reporting be turned off on the device side with this change?

pcan_usb_start() sends this mask to the device on every open and does not
look at ctrlmode:

pcan_usb_start() {
    ...
	err = pcan_usb_set_err_frame(dev, PCAN_USB_BERR_MASK);
    ...
}

The patch also adds CAN_CTRLMODE_BERR_REPORTING to ctrlmode_supported.
However, the only place that flag is checked is pcan_usb_handle_bus_evt().
By then the record has already crossed USB, and can_stats.bus_error and
rx_errors/tx_errors have already been incremented.

For comparison, set_normal_mode() in drivers/net/can/sja1000/sja1000.c
masks the interrupt source when reporting is off:

	if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
		priv->write_reg(priv, SJA1000_IER, IRQ_ALL);
	else
		priv->write_reg(priv, SJA1000_IER,
				IRQ_ALL & ~IRQ_BEI);

Consider a bus error storm, for example a single node with no ACK. Once the
controller is error-passive the old RXERR|TXERR mask stopped producing
records, because TEC stopped changing. With ECC always requested, the
firmware could send a record for every retransmission. The driver then
throws those records away when berr-reporting is off.

Could pcan_usb_start() build the mask as RXERR|TXERR, and add ECC only when
CAN_CTRLMODE_BERR_REPORTING is set? ctrlmode cannot change while the
interface is up, so making the decision at start time should be enough.

[ ... ]

> @@ -550,23 +560,95 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
>  /* decode bus event usb packet: first byte contains rxerr while 2nd one contains
>   * txerr.
>   */

[Severity: Low]
This isn't a bug, but a few comments look stale after this change.

The header comment above pcan_usb_handle_bus_evt() still says the first
byte is rxerr and the second is txerr. The new comment inside the function
says "1st byte is ECC (if BEI), 2nd one is rxerr, 3rd one is txerr". The
code reads ECC, rxerr and txerr from ptr[0], ptr[1] and ptr[2].

The comment above PCAN_USB_BERR_MASK still says:

  /* This mask generates an usb packet each time the state of the bus changes.
   * In other words, its interest is to know which side among rx and tx is
   * responsible of the change of the bus state.
   */

With PCAN_USB_ERR_ECC added, the mask now also requests a report for every
bus error.

The PCAN_USB_REC_BUSEVT case in pcan_usb_decode_status() still reads
"bus event notifications (get rxerr/txerr)". That path now also builds
CAN_ERR_BUSERROR frames.

> -static int pcan_usb_handle_bus_evt(struct pcan_usb_msg_context *mc, u8 ir)
> +static int pcan_usb_handle_bus_evt(struct pcan_usb_msg_context *mc, u8 ir,
> +				   u8 status_len)
>  {
>  	struct pcan_usb *pdev = mc->pdev;
> +	u8 rec_len = status_len & PCAN_USB_STATUSLEN_DLC;
>
> -	/* according to the content of the packet */
> -	switch (ir) {
> -	case PCAN_USB_ERR_CNT_DEC:
> -	case PCAN_USB_ERR_CNT_INC:
> +	/* Check for potential out-of-bound accesses
> +	 * ("end" is a misnomer; it is not a pointer to the last valid byte,
> +	 * but rather to the one following it)
> +	 */
> +	if (!rec_len || (mc->ptr + rec_len) > mc->end)
> +		return -EINVAL;
>
> -		/* save rx/tx error counters from in the device context */
> +	/* 1st byte is ECC (if BEI), 2nd one is rxerr, 3rd one is txerr:
> +	 * save rx/tx error counters from record data bytes first, so that
> +	 * device error counters are always up-to-date.
> +	 */
> +	if (rec_len > 1) {
>  		pdev->bec.rxerr = mc->ptr[1];
> -		pdev->bec.txerr = mc->ptr[2];
> -		break;
> +		if (rec_len > 2)
> +			pdev->bec.txerr = mc->ptr[2];
> +	}

[Severity: Medium]
This new bounds check, together with the rec_len checks around ptr[1] and
ptr[2], appears to also fix an out-of-bounds read that existed before this
patch. Should that fix be a separate patch with a Fixes: tag?

Before this patch, pcan_usb_handle_bus_evt() read mc->ptr[1] and
mc->ptr[2] for ir == 0x00 or 0x80 without checking them against mc->end.
The caller, pcan_usb_decode_status(), only checks the func/num bytes
before the call. The rec_len check runs after the handler returns:

	/* check whether function and number can be read */
	if ((mc->ptr + 2) > mc->end)
		return -EINVAL;
	...
	case PCAN_USB_REC_BUSEVT:
		err = pcan_usb_handle_bus_evt(mc, n);
	...
	if ((mc->ptr + rec_len) > mc->end)
		return -EINVAL;

The RX buffer is a 64 byte kmalloc (PCAN_USB_RX_BUFFER_SIZE). A transfer
that ends right after a BUSEVT header can therefore make the driver read
2-3 bytes past the slab object.

The commit message only says:

  The good old PCAN-USB was missing CAN bus error reporting. This patch
  fixes that.

These reads came from ea8b33bde76c ("can: pcan_usb: add support of
rxerr/txerr counters"). They got their current form in 590eb2b7d8cf
("can: peak_usb: pcan_usb_handle_bus_evt(): fix reading rxerr/txerr
values"), which was Cc'd to stable.

Without a Fixes: tag or a note in the changelog, stable trees have no
reason to pick this up. Could it be split into its own fix, or at least
described in the commit message?

[ ... ]

> @@ -627,7 +709,7 @@ static int pcan_usb_decode_status(struct pcan_usb_msg_context *mc,
>
>  	case PCAN_USB_REC_BUSEVT:
>  		/* bus event notifications (get rxerr/txerr) */
> -		err = pcan_usb_handle_bus_evt(mc, n);
> +		err = pcan_usb_handle_bus_evt(mc, n, status_len);
>  		if (err)
>  			return err;
>  		break;

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch. I
noticed it while looking at this parsing path: can pcan_usb_decode_msg()
read past the end of ibuf[]?

pcan_usb_decode_msg() {
	struct pcan_usb_msg_context mc = {
		.rec_cnt = ibuf[1],
    ...
	for (err = 0; mc.rec_idx < mc.rec_cnt && !err; mc.rec_idx++) {
		u8 sl = *mc.ptr++;
    ...
}

The record count comes from the device, and each status byte is read
without checking that mc.ptr < mc.end.

Take a 64 byte transfer with a 2 byte header that claims 5 records,
followed by BUSEVT records of 18, 18, 18 and 8 bytes. It passes every
bounds check and leaves mc.ptr == mc.end. The 5th iteration then reads
ibuf[64], one byte past the buffer.

In pcan_usb_decode_data() there is also an unchecked increment for the SRR
flag:

		if (can_id_flags & PCAN_USB_TX_SRR)
			mc->ptr++;

That increment can move ptr to end + 1 before the next status byte is
read.

Later checks reject the record, so the overread is limited to 1-2 bytes.
This loop dates back to 46be265d3388 ("can: usb: PEAK-System Technik
PCAN-USB specific part").

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002-peak_usb_enhancements-v1-0-50e965755c06%40pengutronix.de
