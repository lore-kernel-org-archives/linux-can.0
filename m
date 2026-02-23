Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A1E314A9E;
	Mon, 23 Feb 2026 16:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864781; cv=none; b=Oo5X7XuRX1cnpj9mILgOJOxEQEOXWofqeGATWyNW7uzexEA2+mDVEphzQq9gUUvdfapj/SxRy2+HY15HeAQ5s/+DZYn0vCANULMpw4VAs3ahJegbIdFQswZYMzHxi+JnPaHFO2ETLTg3hs5V/s8oH4UcpD1ZXBB+3f3wNxfmjWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864781; c=relaxed/simple;
	bh=o41DBXCI/qgjCzPzhjJ/+ySlhZRDeSbMo3c05x7nLNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yc9DJ3eF2IghR5zM3nlWuby6GD19kfBjqngUfd/Z8MWk4YqlqTl7psjFIOpjYWnpPb7WsgIMJCaE96zm1HgjLNIFI8pM5de8jQwHK4yej/myVZtJOOvPSmwORGUiU2LApRloZB8tIL/6TBbB5N6jzwQ/+0Q1zaCG67PYNIPiGbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xb5vwaB5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xb5vwaB5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C25C19421;
	Mon, 23 Feb 2026 16:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771864781;
	bh=o41DBXCI/qgjCzPzhjJ/+ySlhZRDeSbMo3c05x7nLNw=;
	h=From:To:Cc:Subject:Date:From;
	b=Xb5vwaB5lMFWcEXJ4PemesBENYft5qQjO0j8UBACeSiAuCSHGhpBG9R2sfuD5P6Va
	 fPSXyfrjbDIu+3EP2KcJKzkIKbpU2Ifzl30AWgs3wUxGVK2IRiQrIzX4cAHh1mQT2o
	 0eBTjaPDE/9ex87u5SPRLh54RJhgyvJpEb23FHkw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-can@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	stable <stable@kernel.org>
Subject: [PATCH] can: usb: etas_es58x: correctly anchor the urb in the read bulk callback
Date: Mon, 23 Feb 2026 17:39:20 +0100
Message-ID: <2026022320-poser-stiffly-9d84@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1414; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=o41DBXCI/qgjCzPzhjJ/+ySlhZRDeSbMo3c05x7nLNw=; b=owGbwMvMwCRo6H6F97bub03G02pJDJlzmnbsmf/+omiwi5ro+V9X33ck6B7xuPV85hWnbZ9q9 hxxmui6qSOWhUGQiUFWTJHlyzaeo/srDil6GdqehpnDygQyhIGLUwAmEnubYcGNvXv+mUwWEuh6 cWGzdYvvL6U52Y0MC86F2l1suPDv9YmJTi/0Fsk2W9To3gUA
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

When submitting an urb, that is using the anchor pattern, it needs to be
anchored before submitting it otherwise it could be leaked if
usb_kill_anchored_urbs() is called.  This logic is correctly done
elsewhere in the driver, except in the read bulk callback so do that
here also.

Cc: Vincent Mailhol <mailhol@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: stable <stable@kernel.org>
Assisted-by: gkh_clanker_2000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/usb/etas_es58x/es58x_core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index 2d248deb69dc..b259f6109808 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -1461,12 +1461,18 @@ static void es58x_read_bulk_callback(struct urb *urb)
 	}
 
  resubmit_urb:
+	usb_anchor_urb(urb, &es58x_dev->rx_urbs);
 	ret = usb_submit_urb(urb, GFP_ATOMIC);
+	if (!ret)
+		return;
+
+	usb_unanchor_urb(urb);
+
 	if (ret == -ENODEV) {
 		for (i = 0; i < es58x_dev->num_can_ch; i++)
 			if (es58x_dev->netdev[i])
 				netif_device_detach(es58x_dev->netdev[i]);
-	} else if (ret)
+	} else
 		dev_err_ratelimited(dev,
 				    "Failed resubmitting read bulk urb: %pe\n",
 				    ERR_PTR(ret));
-- 
2.53.0

