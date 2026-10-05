Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E25947F789;
	Mon,  5 Oct 2026 12:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791202444; cv=none; b=E3RR+OplcYsSGplTdccuEZc7WYrGFIcic0zx87F/zPhInTPC0RILuNJIlBJgKg1i7cdplmDOo69hMK8FQdseA3IG8wo5T2mVU64OhpaDesvOJWvpq5H52Z0biL1fLnH+uHD+5PrDwgQ2VO3h4mn7jBv+g4BQkXXlAHXSMgL/UM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791202444; c=relaxed/simple;
	bh=4ZoA1gLbgmDQx+LLpMBYJ2NX0ra88ZCtd7DgXxTfnwE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cv0eCZVyyhUpQFpB8sASM4K3fj81S4wY8WGrh6Q+EbIzasfL3UZT0puFqTFvx9gt7R7qnbS1r+SIkQUGJrmEQLGXciYns6UTOY6mMa6v4XVr6fgbSnPZ1vurgxRMLvsZEIkV2V7GhEPoGUghdyqdjWR25rcOWVhwXmneILp1Q60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndnKKSS5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndnKKSS5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF6A1F00893;
	Mon,  5 Oct 2026 12:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791202439;
	bh=xbhkAptlgTy/9+0hDYr4hF0rdbDX15vCYGCaXXOOWB8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ndnKKSS5QwpTfrnFD3YI69YLKAQAtBOSog2xdLihVEw/RytXJcIVtTtQENIYSLFbq
	 ekSiJMDxXRJ6kxF3jyWgsHyrTO+3OyXz1e3k+ZLqJVQgBiBGmDMmo/AOobjDNXqDoR
	 JuoVk7ctzho4lHndLeQFYXwQKdxMk5FbHjqHfrh5wd0pseTVQ+xcYjInanMR5dsD1H
	 jQ6WxxOJAWPBEnEjgQLgMtn4Fv+rWSjlvy6cxx5r7p4cHkieIEsHiYoTEYQg6ssMf7
	 rqLdyYbGhaKflTEyzDblSt9HjIYw2sTh+Tsqp6B+EAIHNezkBcDQR3h4G6umDFRPOg
	 sSZFgrnKzkJyg==
Subject: Re: [PATCH can-next 10/10] can: gs_usb:
 gs_usb_get_minimum_rx_length(): enforce data_length of 8 bytes for CAN error
 frames
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: mailhol@kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Mon, 05 Oct 2026 12:13:58 +0000
Message-ID: <179120243869.1406898.4158875985954430301@kernel.org>
In-Reply-To:
 <20261004-gs_usb-cleanups-and-fixes-v1-10-7b4b06244a77@pengutronix.de>
References:
 <20261004-gs_usb-cleanups-and-fixes-v1-10-7b4b06244a77@pengutronix.de>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 2 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch fixes the error-frame check for one flag combination
  but misses another.
- [Low] For classic error frames, gs_usb_get_minimum_rx_length() now
  returns data_length = CAN_ERR_DLC (8), and…
- [Low] The commit fixes a regression but has no Fixes: tag.

Pre-existing issues:
- [Low] This problem wasn't introduced by this patch.

--

can: gs_usb: gs_usb_get_minimum_rx_length(): enforce data_length of 8 bytes for CAN error frames

This patch changes gs_usb_get_minimum_rx_length() so that classic CAN
error frames received from the device use a data_length of CAN_ERR_DLC (8)
instead of the length derived from the DLC. With that change, both the
minimum URB length check and the copy into cf->data cover the error frame
payload that gs_update_state() reads.

> therefore, for error frames increase the value of data_length in
> gs_usb_get_minimum_rx_length() to CAN_ERR_DLC.
>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

[Severity: Low]
Should this have a Fixes: tag?

Commit 395d988f9386 ("can: gs_usb: gs_usb_receive_bulk_callback(): check
actual_length before accessing data") changed the classic copy from this:

    memcpy(cf->data, hf->classic_can->data, 8);

to a copy based on data_length. After that change, gs_update_state() reads
a zeroed cf->data[1] for error frames with can_dlc < 2.

395d988f9386 has its own Fixes: tag and is a stable candidate. Would adding
the following help stable trees pick up this correction too?

Fixes: 395d988f9386 ("can: gs_usb: gs_usb_receive_bulk_callback(): check actual_length before accessing data")

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index 3d49a73446927..dd01fd22510e2 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -576,8 +576,12 @@ gs_usb_get_minimum_rx_length(const struct gs_can *dev, const struct gs_host_fram
>  			minimum_length = sizeof(hf->header) + data_length;
>  	} else {
>  		if (hf->echo_id == GS_HOST_FRAME_ECHO_ID_RX &&
> -		    !(hf->can_id & cpu_to_le32(CAN_RTR_FLAG)))
> -			data_length = can_cc_dlc2len(hf->can_dlc);
> +		    !(hf->can_id & cpu_to_le32(CAN_RTR_FLAG))) {
> +			if (hf->can_id & cpu_to_le32(CAN_ERR_FLAG))

[Severity: High]
Does a frame with both CAN_ERR_FLAG and CAN_RTR_FLAG set still end up with
data_length == 0 here?

The new CAN_ERR_FLAG test sits inside the !CAN_RTR_FLAG condition. A
classic RX frame from the device with both flags set in can_id therefore
gets data_length = 0. Without GS_CAN_FEATURE_HW_TIMESTAMP, minimum_length
is then just sizeof(hf->header).

gs_usb_receive_bulk_callback() then copies nothing. It still calls
gs_update_state(), because that call only tests CAN_ERR_FLAG:

    memcpy(cf->data, hf->classic_can->data, data_length);

    /* ERROR frames tell us information about the controller */
    if (le32_to_cpu(hf->can_id) & CAN_ERR_FLAG)
        gs_update_state(dev, cf);

If CAN_ERR_CRTL is also set, gs_update_state() reads cf->data[1]. That
byte is the zero fill from alloc_can_skb(), not data from the device, so
the code takes this branch:

    } else {
        dev->can.state = CAN_STATE_ERROR_ACTIVE;
    }

The driver then reports error active instead of the warning or passive
state the device sent. It also skips the error_warning and error_passive
counters.

With GS_CAN_FEATURE_HW_TIMESTAMP enabled, the URB must already contain the
full data field, but those bytes are still not copied.

Before 395d988f9386 the classic path always copied 8 bytes, so this flag
combination is still a regression after this patch. Could CAN_ERR_FLAG be
tested before the RTR exclusion, or could ERR|RTR frames be rejected?

> +				data_length = CAN_ERR_DLC;

[Severity: Low]
For classic error frames the copy length is now CAN_ERR_DLC. However,
gs_usb_receive_bulk_callback() still sets cf->len from the device's
hf->can_dlc:

    can_frame_set_cc_len(cf, hf->can_dlc, dev->can.ctrlmode);

    memcpy(cf->data, hf->classic_can->data, data_length);

can_frame_set_cc_len() only clamps the value to CAN_MAX_DLEN. Suppose a
device sends an error frame with can_dlc < 8. Would userspace then get a
frame with cf->len < CAN_ERR_DLC, while the driver has copied and acted on
bytes past cf->len? Since 395d988f9386 the copy length and cf->len always
matched.

The commit message says "By definition, CAN error frames have a length of
CAN_ERR_DLC (= 8) bytes". Should cf->len also be set to CAN_ERR_DLC for
error frames?

> +			else
> +				data_length = can_cc_dlc2len(hf->can_dlc);
> +		}

[ ... ]

[Severity: Low]
This is a pre-existing issue, not one introduced by this patch.
gs_usb_receive_bulk_callback() passes the raw hf->can_dlc from the device
to can_frame_set_cc_len() without checking its range:

    can_frame_set_cc_len(cf, hf->can_dlc, dev->can.ctrlmode);

The helper in include/linux/can/length.h expects the caller to have
checked the value already:

    /* the caller already ensured that dlc is a value from 0 .. 15 */
    if (ctrlmode & CAN_CTRLMODE_CC_LEN8_DLC && dlc > CAN_MAX_DLEN)
        cf->len8_dlc = dlc;

gs_make_candev() advertises CAN_CTRLMODE_CC_LEN8_DLC. With cc-len8-dlc
enabled, can a device that sends can_dlc > 15 pass a len8_dlc value of up
to 255 to raw socket readers?

In-kernel users read the value through can_get_cc_dlc(), which rejects
values above CAN_MAX_RAW_DLC.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261004-gs_usb-cleanups-and-fixes-v1-0-7b4b06244a77%40pengutronix.de
