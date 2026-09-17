Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152CE4A7CAF;
	Thu, 17 Sep 2026 09:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789636870; cv=none; b=fIoryP4wYtolsHwIbnBQqe15Y/dgqO/ggaz4xNvgJ6pW4KqJGMXGnOAcdi9Vui0K5jnem5zmjYYL7bkhfl0odLu+jxw2A2sY6EXKnyt4m4VFprWTX7Yd3lTzF4SzgjHxH9SYe/XPusX9Ows7DzbSvpWmdAJurmonuw3QZ/oq40M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789636870; c=relaxed/simple;
	bh=ZgNFxzBa1zSn/0VCMvoIUJCMC6bFAXfaIC4EDdtxM6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKhN2ZncBC6w4x2ubYGyNqX0B/Wa8P4E7p/dil3MDL7aQhfnXnZYyc1fYu0JWC4HNAKaUS8tnlw63Zu939QUEwXFJjcri3i2q3WJi8LyNlVCCdyRViadO/st5//r1De7YoQ9a02JcF9YIsrTERJRG5tCC3O0NC7F+iHHqtjVOtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=L2OVHW+/; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="L2OVHW+/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=I9
	V258R7G7mU3ZPKR+50/yT7IMbZ/MJAS9R6oXcwARs=; b=L2OVHW+/3Dr07a9QZn
	kHBbrd3UZlrlIaLfXl7F4ON7f9vrGBO/cxmyktWrLHkw+Yury5AyAUZFmaC2NRMN
	qVRg9knYnTR7a7viMqbYeErPwi9NB3e6q9YIlgbrMLgAjUAwm7uvkc91I/Z36Lir
	BoCcCjgflC/dMd0jpnPLu39qU=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAH7qHusKtqAAJBBA--.10S2;
	Thu, 17 Sep 2026 17:20:48 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5] dt-bindings: net: can: convert ifi_canfd to DT schema
Date: Thu, 17 Sep 2026 17:20:46 +0800
Message-ID: <20260917092046.388076-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <70ae05a5-2415-4895-bc64-37b3d3ba54ac@kernel.org>
References: <20260914022145.408976-1-quchaosheng000406@163.com> <70ae05a5-2415-4895-bc64-37b3d3ba54ac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAH7qHusKtqAAJBBA--.10S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CryktFWrKF43Gw13Wr17Jrb_yoW8XFWfpF
	ZxKrnFka1DtF1Ik34ktr4xta4jvws3uFWrGFy5tryUA3W5JFW2qryfK34UAa4kur4fCr1a
	vwsIgwn3GFZayFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRAu4UUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC-xHtY2qrsPE-WgAA3F

Hi Krzysztof,

You are right, and sorry for the noise. I have stopped sending. Nothing is
queued, and I will not repost the three CAN bindings unless you ask me to.

What I got wrong, and what is fixed before anything goes out again:

1. Threading. I attached new versions to older threads and unrelated
   patchsets. That is exactly what submitting-patches.rst warns about: it
   buried the patches and made Patchwork show several versions of one file.
   The next posting is one series, in its own thread, one version only.

2. spi-peripheral-props. Dropped, as you asked. The binding now references
   only can-controller.yaml, and dt_binding_check passes.

3. clock-frequency. Dropped, and clocks stays required. You were right that
   it is ACPI-only; I had argued from the driver code instead of reading the
   git history.

4. Commit messages rewritten as short declarative sentences that describe
   only what changed in the binding.

5. One thing I should have said from the start: these patches were prepared
   with an LLM coding assistant. Per
   Documentation/process/coding-assistants.rst they need an
   "Assisted-by: LLM" tag, and mine did not carry one. It is now on every
   patch. You told me not to paste LLM text, and I should also have
   disclosed that the text was LLM-assisted. Not doing that was the worst
   part of this, not the wording.

The bindings are otherwise unchanged. holt, mpc5xxx-mscan and ifi,canfd are
ready as a single clean v7 series. Tell me when you want it and I will post
it in one new thread.

Thanks for the pointers.

Quchaosheng

