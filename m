Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACED37F314
	for <linux-can@vger.kernel.org>; Thu, 23 Jul 2026 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784822155; cv=none; b=H/8UZbDOamvi2awEmVlSGqdDGsXb7LCAUulrsikFK8tcOz9pBY7SuwiKLOvOJRHjbvO2R10KMcTZ8/77sOTq5vjcztBQfXcaQDH84mvnfFP1m36+4FIpDhbaXBxQ2lv6r3NBIQPoK6C/BX9pkMorgBePkZ5yWhjnDgtL/UtxCEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784822155; c=relaxed/simple;
	bh=SY8tYPM/nr1IJHqIxCkcvSI7a+QboJC0bygVeKDz+2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fnJddX0s8mjm+aHKFZat6XQu6ri/VXPFwtx7X5LeO/brj00D7cZAlOUsckXXLJ5r1OZYJFybj3aT8UX9nli4MJPkqRlGAnr8fR+GWSwLwDHvBp1bWjK7DYiScXEvWmGbd9AMk48Nm7qlqQauxHHqJRMPN8XcajDA7I4v4Ra+fTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+NO3eWW; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+NO3eWW"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so8981455e9.2
        for <linux-can@vger.kernel.org>; Thu, 23 Jul 2026 08:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784822149; x=1785426949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zeZ+AywV9mg1yaRsPn1N3K/jF4bEsmN09Ss25mKGkmY=;
        b=F+NO3eWWyXRZIwoK4epB9yixxvAsIjFLd9ILbDLske67jEe+clNxF/O4bSTUGdJdgu
         GRmphTKhjuKYu69Ykkvi2rVmlMWcxmnbys0GBDFQqaLj2ntA7FiAcBhXIlDsua2jTHes
         uHo7m1BjDZbDk52nl/V1/g9ZNVJBTGsTmNCIkpHLQIGZjK0DhjSig2yYkOpcKDUZflMF
         ZCsHkweJfVNQUNckPa7epIyGegw72YPEAVgG/250TJ6AsvhpIlXTyCOpYPrwZ6JvAGKr
         pPYUwlc1anyRH8yBsvLhg3NCTsDnmkaEtb5rkhqqUT8mVlJrAj16n6BYNX7KN8sEi7Xp
         7tQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784822149; x=1785426949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zeZ+AywV9mg1yaRsPn1N3K/jF4bEsmN09Ss25mKGkmY=;
        b=kiQ1mUV+e3dzl9het7Nbl3xfMmpzd5SqpNPZ9CocLL/h8EFSAGB//cu6x0LOz/Fskp
         Df5FXTzMmV/YS0NzcBwM7D+Xcc4JsBaKDlyjb1n07MlHLzeN/TR+4avOFfF9Dh17c9eD
         m+DdbX0IQxWHGXWv/k7G55V1qCAEmjKNukBPIqVjeMVHZ+lLcHRoH/W0J4jvoIFXzsA8
         rTld+NDVqfHqDDaYNQH4CVB5EVl/5DRo0Why3Yqvk6c8J11FuVWza2y2BCj9AOsPUOxM
         DfWWagNFyTYAJnL+GPlYYxfsnvptyAFrGwU5k3bTxY//wBh22RX/P0dmbtU50OR0bsKQ
         AYhw==
X-Gm-Message-State: AOJu0YyYgGwWksD8s3z6Sekdts85zQRZ7fqQ0dmTqa6bk7EMunGXosQH
	NWgCfR7VWbURhsBl6eBtVbUX5T6ppTJcWSxoXftkp0oPmfBMgeTwimj5hkMhVkUjT4+VPg==
X-Gm-Gg: AR+sD111PZ/jHikSSa8VthJ88fcDSc153vdun8hKOrTjkYjC4l0l6H0Hld//rsxBsXK
	4jAVHdErE/acPL6RNxEdNV4X82aDIQ5nen6fKI+GTjczpW6KivTRRLfCyaAJQRDWHj31DkerZVa
	zbWx67JrN1inbdMnHXkk1dWEE+GiV05Pw9G8jO++jKZUWRsgAs+guEojhf99jh4W0kRz5FLPwDo
	zcq6EwlPeWAFm7UPFoT6X8dKcJNiGNXLovJsVH5yS3pld0MWw+lZL2OVMgoJHnydJC2jhqen0IJ
	JjN8QaRwYXwTV6Yyfv4WIbH79mqEOONt6Hn9Deu6E/AzBfDVuUtoEJkozg446XW9K9xCI0vznK3
	lNroTRluj0EKkwiznUOxhp7UzYyOkfLJvQ/tPW8rNOzRgGktT8vLmm+qLbee0LimjJ4bF/YJJ79
	wXySOUNdrTEiAFHBSp+LcvxMb2Bts=
X-Received: by 2002:a05:600c:3111:b0:495:779a:ed33 with SMTP id 5b1f17b1804b1-495779aeefcmr22201895e9.7.1784822148966;
        Thu, 23 Jul 2026 08:55:48 -0700 (PDT)
Received: from LAPTOP-AVI.taile24b5.ts.net ([2a00:a040:1b7:4f41:6d3b:a1f4:a60d:9981])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956ab2f0a2sm105540505e9.1.2026.07.23.08.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 08:55:48 -0700 (PDT)
From: Avi Weiss <thnkslprpt@gmail.com>
To: linux-can@vger.kernel.org
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>,
	Ondrej Ille <ondrej.ille@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH net] can: ctucanfd: mark error-active controller status valid
Date: Thu, 23 Jul 2026 18:55:43 +0300
Message-ID: <20260723155543.318414-1-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the CAN_STATE_ERROR_ACTIVE case, cf->data[1] is set to
CAN_ERR_CRTL_ACTIVE, but cf->can_id is not set with CAN_ERR_CRTL in
that path.

Set CAN_ERR_CRTL so consumers know the controller-status information
in cf->data[1] is valid.

Fixes: 9bd24927e3ee ("can: ctucanfd: handle skb allocation failure")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 drivers/net/can/ctucanfd/ctucanfd_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/ctucanfd/ctucanfd_base.c
index 0ea1ff28dfce..8f8b1c097ec6 100644
--- a/drivers/net/can/ctucanfd/ctucanfd_base.c
+++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
@@ -869,7 +869,7 @@ static void ctucan_err_interrupt(struct net_device *ndev, u32 isr)
 			break;
 		case CAN_STATE_ERROR_ACTIVE:
 			if (skb) {
-				cf->can_id |= CAN_ERR_CNT;
+				cf->can_id |= CAN_ERR_CRTL | CAN_ERR_CNT;
 				cf->data[1] = CAN_ERR_CRTL_ACTIVE;
 				cf->data[6] = bec.txerr;
 				cf->data[7] = bec.rxerr;
-- 
2.43.0

