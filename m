Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793797317;
	b=lVPWl6RUy6ipGMSJr4oWMnVuapzsKMWOqM/aqP3LXcl2c9OiNL6/obB4bC6FodFl6iHN
	 co04tsi5qeL3NVU7vPURwcQHKhtehLwi+XglujhwIOzflN2ea+nSN+d5gF4EAde4uhbKK
	 iSyB4CD8Rm73yYAYyO0R06d2WRHEweRmzu95LJJt2IOC0JCYgT3vuN/9T4UN3teH38U8l
	 WV/eJsPDflf3rcs7xNswPbXA29AiIC5fPd57a8g97bw0YAfGfmm+S3PIjvYrI89m/HOSB
	 jFWLFKBu5rNfyNI5FDMthExJkIxoHAiBCYP5LrB0KS90I9Z9ibpo1uvtLvjG48Ml1Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793797317;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=kNp1OKGwredcYBJajnfjoxaLNZXBTsBj+yElvIWNzNo=;
	b=CLAUn4ITMrMOwQ+Id/I6zYv8qjIsJBfw1dSf23VUAdoZ+zzeOAjs2DhNgKuFoVimS2Ng
	 awVyL4Ntpw70NqnrCetejdex8WAuPk+Sb4GThU4tBrya4P/JORtw3oIqFQIozqVxaRcFy
	 r0U6peXKe7EowKsK4jh0tB1aD+o2zgdy9hGG+du0TW6asegJyUOWchdS7RsSzFltiFQ9A
	 d31p/GktOvsHC6O/+nrjsgawYw7VrkXKz6Qh4GYaXNIw+ZqHHh3BwX/DYa07B8NOLkX1W
	 GHblwrZDWCjVX0FDPmmJjW7gEs1ynKi1XHzsD5sUqXD+GUMcjwADuBlESxtktwqL2yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Phc041Sg;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6EA606D815
	for <linux-can@vger.kernel.org>; Wed,  4 Nov 2026 13:01:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A6EA606D815
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Phc041Sg
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a5720b0a57so11027695e9.0
        for <linux-can@vger.kernel.org>; Wed, 04 Nov 2026 05:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793797315; x=1794402115; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kNp1OKGwredcYBJajnfjoxaLNZXBTsBj+yElvIWNzNo=;
        b=Phc041SgLYCqrjtXEjvGfFGBR1JLA1eo7DWMT0alOPb7jg/IIoTXYM50ovILIggbrC
         vR9mAuAYJiXt0olkq3vNux0ybiesloKRlscheeep+0VA04qfBTGdnwVZPPTMKPAbwlc5
         Vvjik3M37dZKksZE89oaJ/YkKMYroBF6U/l85WGcSLYuylPfbbkHkshDRFHOF3lAfgsw
         54saGgWwrjXV+eSUFbvJfWe6I1VedSDuE+lYfjgDNozxxOgdJumqv1eQ2BCEUbLna1q1
         4H3zacuCoAIuhpx7LiSb2kwx2WeQN9zwxo196JBIdrVKy31k/hQ5PCwZMGIHKrHDYTsb
         khNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793797315; x=1794402115;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kNp1OKGwredcYBJajnfjoxaLNZXBTsBj+yElvIWNzNo=;
        b=uchTlcUxQg7yLzKLJbKYjfgNXqVwnkFU5LLs+JrmcCLbL6lEoSCUNQnNRmeIEKzphW
         ybo8qucLHcE/ZiX62RaWeG+gghQSLRn4sNNQmp6YU98AXUAS3H3Nf0QxkzkTy6/TLU3I
         4QAg23XqDx5+WBRGStAC8MIdoRxkgDvZXcD13+pBHCgrOoQ0PLh1A2IS6E6YiJoDy/PE
         PkDcJQ2D50bOaZEq/YzkV9tgG7abnDv+LzV5Y/ML5/HZHk2gH2sq9nfR223vDxltclto
         2OjnMzpp76x4tj1ZvksxEYMwKqIUUXTuAGxGUlg2cUW+4/T5UBURbvhCCVnSSXXiHfER
         08fA==
X-Forwarded-Encrypted: i=1; AKwUvBziMyZb+cfUkxUYR46EIWRSrXoUeJ3lXRDq11M6JJITX3+jq3hIazZCDzaDIRdKWbA4sgiLmUFF8XY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/M6JenVtbWsDcFoZ5XQf+veHlzVSG/UolPQM02/ygocXhu6t3n
	8NVt6SR0cGzTj7UW7AYjX7hh17ufufZCHRv5fMc59484Zo7QXDSIH+0=
X-Gm-Gg: AYBFou0CkDRE0m84iZAiOmCacWDHPkc/xRmgUrt8cCUS2S1wbHaSTuK9ypefnEyx/Im
	Hf70Koa3eppiqkLseHQWipzg3ItTsWL2r4jp6XezW26iCFE3mHjhgKQZh+xGjHU8m+y+AYB8/m+
	12imSKFs5F/1K4JZDy/qmHdYmqxo334DLVI9pKsynm4A3Odn3IrVomnOlFiWm78v3Z9VboPjF+4
	9hQEiuviJGopWYSrwrLnkk450/REYFkL9+R3ju2boX/NjMSVCBhBcPUOUmc2Jz4WzTl+LSYe0cV
	P60WsZ/pNxFJ7rFze59Wm274f0up4CuyeFbIBx/Doqf3aYCZxnsWT33N9rJBzTkIOHno24D2YSn
	4pkNA9eiZ0RdYB70j7FCOIy8puAY1KKHiFpmvpUaLnuvXGdaqX3XVTGZlHsTCEFEmneNVsUVW1P
	kj409Dd/ePhqLEvZXxt7Ac5O0N5dlg+MXJhAAOYaph1LhzhW/DJ8BH8C3ko4cliMQYboSdaIGIo
	Ebsp6YQiSlbfTxFO1YL2Gd8RlMQ69p8ZG5w77Fr2K4KJuBcRddAf6SKyknYi7Echw0GhDYw3Q==
X-Received: by 2002:a05:600c:8116:b0:4a0:20b4:ba93 with SMTP id 5b1f17b1804b1-4ac17e10724mr366339745e9.16.1793797315382;
        Wed, 04 Nov 2026 05:01:55 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2aa38bb4asm140292765e9.6.2026.11.04.05.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 05:01:53 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: robin@protonic.nl,
	o.rempel@pengutronix.de,
	socketcan@hartkopp.net,
	mkl@pengutronix.de,
	kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kuba@kernel.org
Subject: Re: [PATCH net] can: j1939: fix skb refcount underflow in session teardown paths
Date: Wed,  4 Nov 2026 13:01:51 +0000
Message-ID: <20261104130151.2659605-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179376780412.488853.11738408007557929503@kernel.org>
References: <20261102155345.1267524-1-tristan@talencesecurity.com> <179376780412.488853.11738408007557929503@kernel.org>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

On Wed, 04 Nov 2026, netdev-bot+sashiko@kernel.org wrote:
> [Severity: Critical]
> Does this leak every skb on session->skb_queue?

Yes, this is correct.  Queued skbs carry refcount 2 (one from the
allocation and one from skb_get in j1939_session_new /
j1939_session_skb_queue), so the existing skb_unref + kfree_skb
sequence is the intended teardown path.  Removing skb_unref would
leave every skb at refcount 1 after kfree_skb, leaking it.

Withdrawing this patch.

pw-bot: cr
