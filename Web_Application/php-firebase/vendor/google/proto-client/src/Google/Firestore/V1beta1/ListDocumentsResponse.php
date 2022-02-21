<?php
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/firestore/v1beta1/firestore.proto

namespace Google\Firestore\V1beta1;

use Google\Protobuf\Internal\GPBType;
use Google\Protobuf\Internal\RepeatedField;
use Google\Protobuf\Internal\GPBUtil;

/**
 * The response for [Firestore.ListDocuments][google.firestore.v1beta1.Firestore.ListDocuments].
 *
 * Generated from protobuf message <code>google.firestore.v1beta1.ListDocumentsResponse</code>
 */
class ListDocumentsResponse extends \Google\Protobuf\Internal\Message
{
    /**
     * The Documents found.
     *
     * Generated from protobuf field <code>repeated .google.firestore.v1beta1.Document documents = 1;</code>
     */
    private $documents;
    /**
     * The next page token.
     *
     * Generated from protobuf field <code>string next_page_token = 2;</code>
     */
    private $next_page_token = '';

    public function __construct() {
        \GPBMetadata\Google\Firestore\V1Beta1\Firestore::initOnce();
        parent::__construct();
    }

    /**
     * The Documents found.
     *
     * Generated from protobuf field <code>repeated .google.firestore.v1beta1.Document documents = 1;</code>
     * @return \Google\Protobuf\Internal\RepeatedField
     */
    public function getDocuments()
    {
        return $this->documents;
    }

    /**
     * The Documents found.
     *
     * Generated from protobuf field <code>repeated .google.firestore.v1beta1.Document documents = 1;</code>
     * @param \Google\Firestore\V1beta1\Document[]|\Google\Protobuf\Internal\RepeatedField $var
     * @return $this
     */
    public function setDocuments($var)
    {
        $arr = GPBUtil::checkRepeatedField($var, \Google\Protobuf\Internal\GPBType::MESSAGE, \Google\Firestore\V1beta1\Document::class);
        $this->documents = $arr;

        return $this;
    }

    /**
     * The next page token.
     *
     * Generated from protobuf field <code>string next_page_token = 2;</code>
     * @return string
     */
    public function getNextPageToken()
    {
        return $this->next_page_token;
    }

    /**
     * The next page token.
     *
     * Generated from protobuf field <code>string next_page_token = 2;</code>
     * @param string $var
     * @return $this
     */
    public function setNextPageToken($var)
    {
        GPBUtil::checkString($var, True);
        $this->next_page_token = $var;

        return $this;
    }

}
